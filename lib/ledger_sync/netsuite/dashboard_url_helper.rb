# frozen_string_literal: true

module LedgerSync
  module NetSuite
    class DashboardURLHelper < LedgerSync::Ledgers::DashboardURLHelper
      def resource_path # rubocop:disable Metrics/CyclomaticComplexity
        @resource_path = case resource
                         when NetSuite::Account
                           "/app/accounting/account/account.nl?id=#{resource.ledger_id}"
                         when NetSuite::Currency
                           "/app/common/multicurrency/currency.nl?id=#{resource.ledger_id}"
                         when NetSuite::Customer, NetSuite::Vendor
                           "/app/common/entity/entity.nl?id=#{resource.ledger_id}"
                         when NetSuite::Department
                           "/app/common/otherlists/departmenttype.nl?id=#{resource.ledger_id}"
                         when NetSuite::Deposit, NetSuite::Invoice
                           "/app/accounting/transactions/transaction.nl?id=#{resource.ledger_id}"
                         when NetSuite::LedgerClass
                           "/app/common/otherlists/classtype.nl?id=#{resource.ledger_id}"
                         when NetSuite::Subsidiary
                           "/app/common/otherlists/subsidiarytype.nl?id=#{resource.ledger_id}"
                         end
      end
    end
  end
end
