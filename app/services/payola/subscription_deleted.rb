module Payola
  class SubscriptionDeleted
    def self.call(event)
      stripe_sub = event.data.object

      sub = Payola::Subscription.find_by!(stripe_id: stripe_sub.id)

      sub.cancel! if sub.may_cancel?
    end

    def self.to_proc
      Proc.new { |event| self.call(event) }
    end
  end
end
