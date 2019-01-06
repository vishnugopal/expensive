require "lurn"

module Expensive
  module Classifiers
    SUB_CATEGORIES = ["Shopping/Home Groceries",
                      "Shopping/Amazon Shopping",
                      "Shopping/Flipkart Shopping",
                      "Shopping/Apple iTunes",
                      "Shopping/Clothes",
                      "Shopping/Other Software Purchases",
                      "Shopping/Other Online Shopping",
                      "Subscriptions & Recurring/Kickstarter Campaigns",
                      "Subscriptions & Recurring/Namecheap Domain Renewal",
                      "Subscriptions & Recurring/Digital Ocean Hosting",
                      "Subscriptions & Recurring/Amazon Subscriptions",
                      "Subscriptions & Recurring/Adobe Subscription",
                      "Subscriptions & Recurring/Microsoft Subscription",
                      "Subscriptions & Recurring/Netflix Subscription",
                      "Subscriptions & Recurring/Fastmail Subscription",
                      "Subscriptions & Recurring/Backblaze Subscription",
                      "Subscriptions & Recurring/Patreon Subscriptions",
                      "Subscriptions & Recurring/Above Avalon Subscription",
                      "Subscriptions & Recurring/Audible Subscription",
                      "Personal Care & Entertainment/Eats",
                      "Personal Care & Entertainment/Drinks",
                      "Personal Care & Entertainment/Spa & Massage",
                      "Personal Care & Entertainment/Soul Food",
                      "Travel & Eating Out/Train Tickets",
                      "Travel & Eating Out/TrainFlight Tickets",
                      "Travel & Eating Out/TrainHotel Expenses",
                      "Travel & Eating Out/TrainLounge Fee",
                      "Health/Hospitals & Medicines",
                      "Health/Gym",
                      "Utilties/Electricity Bill",
                      "Donations/Milaap",
                      "Loans/To Friends",
                      "Wallets/Paytm",
                      "Fees/International Card Fees"]

    CATEGORIES = SUB_CATEGORIES.map { |sub_category| sub_category.split("/")[0] }.uniq

    class Expense
      def initialize
        expenses = ["QUICK CONVENIENCE STOR ERNAKULAM",
                    "CLEARTRIP PVT LTD MUMBAI",
                    "PAYTM NOIDA",
                    "ITUNES.COM/BILL 0008001009",
                    "WWW DUNZO IN GURGAON",
                    "SUNDAY THE SPA BANGALORE",
                    "DRI*ADOBE SALES SHANNON",
                    "PAYPAL *SC* ANDROID CE 4153356768",
                    "FRESH HEALTHY BLR BANGALORE",
                    "AMAZON SELLER SERVICES MUMBAI",
                    "TRS T10 SHA BLR BANGALORE",
                    "AMAZON STANDING INSTRUCMUMBAI",
                    "PAYTM APP NOIDA",
                    "GRAVITY FITNESS COCHIN",
                    "PAYPAL *PATREON INC M 4029357733",
                    "PAYPAL *VLADYATS 4029357733",
                    "IGST-VPS1830701522113-RATE 18.0 -32 (Ref# VT183070069015130000212)",
                    "ITUNES.COM/BILL ITUNES.COM",
                    "MICROSOFT*OFFICE 365 HOMEMSBILL.INF",
                    "SILVERLINE HOSPITAL KOCHI",
                    "NETFLIX.COM Amsterdam",
                    "SILVERLINE HOSPITAL Kadavanthr",
                    "PPLoungeFee 05082018 Cochin 1+0 (Ref# ST183130078000010005658)",
                    "IGST-VPS1831307425676-RATE 18.0 -32 (Ref# ST183130078000010005658)",
                    "HOTEL CRYSTAL PLAZA ERNAKULAM",
                    "IGST-VPS1831815966904-RATE 18.0 -32 (Ref# VT183180069014510000229)",
                    "HOTEL ORCHID COCHIN",
                    "CONSOLIDATED FCY MARKUP FEE (Ref# VT183180069014510000229)",
                    "DIGITALOCEAN.COM DIGITALOCE USD 14.16",
                    "Audible US 888-283-50 USD 14.95"].map(&:upcase)

        categories = ["Shopping",
                      "Subscriptions & Recurring",
                      "Personal Care & Entertainment",
                      "Travel & Eating Out",
                      "Health",
                      "Utilties",
                      "Donations",
                      "Wallets",
                      "Loans",
                      "Fees"]

        mapped_categories = ["Shopping",
                             "Travel & Eating Out",
                             "Wallets",
                             "Shopping",
                             "Shopping",
                             "Personal Care & Entertainment",
                             "Subscriptions & Recurring",
                             "Shopping",
                             "Shopping",
                             "Shopping",
                             "Travel & Eating Out",
                             "Subscriptions & Recurring",
                             "Wallets",
                             "Personal Care & Entertainment",
                             "Subscriptions & Recurring",
                             "Loans",
                             "Fees",
                             "Shopping",
                             "Subscriptions & Recurring",
                             "Health",
                             "Subscriptions & Recurring",
                             "Health",
                             "Travel & Eating Out",
                             "Fees",
                             "Travel & Eating Out",
                             "Fees",
                             "Travel & Eating Out",
                             "Fees",
                             "Subscriptions & Recurring",
                             "Subscriptions & Recurring"]

        @vectorizer = Lurn::Text::WordCountVectorizer.new
        @vectorizer.fit(expenses)
        vectors = @vectorizer.transform(expenses)

        @model = Lurn::NaiveBayes::MultinomialNaiveBayes.new
        @model.fit(vectors, mapped_categories)
      end

      def guess(string:)
        new_vectors = @vectorizer.transform([string])

        # return guess and probability
        [@model.max_class(new_vectors.first), @model.max_probability(new_vectors.first)]
      end
    end
  end
end
