require "active_support/core_ext/string"
require_relative "parsers/hdfc_credit_card"

module Expensive
  class Parser
    def self.parse(file:)
      klass = find_class_for(file: file)
      klass.new(file: file).parse
    end

    def self.find_class_for(file:)
      file_contents = File.read(file)
      klass = if file_contents.match /HDFC Bank Credit Cards/
                :HdfcCreditCard
              end

      "Expensive::Parsers::#{klass}".constantize
    end
  end
end
