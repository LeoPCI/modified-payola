module Payola
  class SyncSubscription
    def self.call(event)
      stripe_sub = event.data.object

      sub = Payola::Subscription.find_by!(stripe_id: stripe_sub.id)

      sub.sync_with!(stripe_sub)
    end

    def self.to_proc
      Proc.new { |event| self.call(event) }
    end
  end
end
