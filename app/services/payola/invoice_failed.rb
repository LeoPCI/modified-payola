module Payola
  class InvoiceFailed
    require_relative './invoice_behavior.rb'

    # include Payola::InvoiceBehavior

    def self.call(event)
      sale, charge = create_sale_from_event(event)

      return unless sale

      sale.error = charge.failure_message
      sale.save!
      sale.fail!

      sale
    end
  end
end
