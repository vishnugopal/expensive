module Expensive
  module Parsers
    class HdfcCreditCard
      def initialize(file:)
        @file_contents = File.read(file)
      end

      def parse
        file_contents = @file_contents
        transaction_header_regex = /Date(\s+)Transaction Description(\s+)Amount(\s+)\(in Rs.\)/
        transaction_header = transaction_header_regex.match(file_contents)[0]
        transaction_pos = file_contents.index(transaction_header_regex)

        transaction_pos_start = (transaction_pos + transaction_header.length + 1)
        transaction_pos_end = -1

        file_starting_transactions = file_contents[transaction_pos_start..transaction_pos_end]

        date_regex = /([0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4,4})/
        amount_regex = /([0-9,]+)\.[0-9]{2,2}/

        transaction_lines = []

        file_starting_transactions.split("\n").each do |possible_transaction_line|
          if possible_transaction_line.index(/\s*#{date_regex}/)
            transaction_line = possible_transaction_line
            transaction_lines << transaction_line.strip.squeeze(" ")
          end
        end

        parsed_transactions = []

        transaction_lines.each do |transaction_line|
          amount_match = transaction_line.match(/#{amount_regex}$/)
          amount = amount_match[0] if amount_match
          if amount
            date_match = transaction_line.match(/#{date_regex}/)
            date = date_match[0] if date_match

            metadata_regex = /#{date}(.*?)#{amount}/
            metadata = transaction_line.match(metadata_regex)[1].strip
            parsed_transactions << [date, metadata, amount]
          end
        end

        parsed_transactions
      end
    end
  end
end
