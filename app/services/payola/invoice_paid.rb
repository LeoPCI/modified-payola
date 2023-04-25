module Payola
  class InvoicePaid
    require_relative './invoice_behavior.rb'

    # include Payola::InvoiceBehavior

    def self.call(event)
      sale, charge = create_sale_from_event(event)

      return unless sale

      sale.save!
      sale.finish!

      sale
    end

    def self.to_proc
      Proc.new { |event| self.call(event) }
    end
  end
end
