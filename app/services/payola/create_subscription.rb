# module Payola
#   class CreateSubscription
#     def self.call(options = {})
#       owner = options[:owner] || nil
#       plan = options[:plan]
#       affiliate = options[:affiliate]

#       if options[:stripe_customer_id].present?
#         customer = Stripe::Customer.retrieve(options[:stripe_customer_id], Payola.secret_key.to_s)
#         email = customer.email
#       else
#         email = options[:stripeEmail]
#       end

#       sub = Payola::Subscription.new do |s|
#         s.plan = plan
#         s.email = email
#         s.stripe_token = options[:stripeToken] if plan.amount > 0
#         s.affiliate_id = affiliate.try(:id)
#         s.currency = plan.respond_to?(:currency) ? plan.currency : Payola.default_currency
#         s.coupon = options[:coupon]
#         s.signed_custom_fields = options[:signed_custom_fields]
#         s.setup_fee = options[:setup_fee]
#         s.quantity = options[:quantity]
#         s.trial_end = options[:trial_end]
#         s.stripe_customer_id = customer.id if customer

#         s.owner = owner
#         s.amount = plan.amount
#       end
      
#       Payola.queue!(Payola::ProcessSubscription, sub.guid) if sub.save

#       sub
#     end
#   end
# end

module Payola
  class CreateSubscription
    def self.call(params, owner=nil)
      plan = params[:plan]
      affiliate = params[:affiliate]

      if params[:stripe_customer_id].present?
        customer = Stripe::Customer.retrieve(params[:stripe_customer_id], Payola.secret_key.to_s)
        email = customer.email
      else
        email = params[:stripeEmail]
      end

      sub = Payola::Subscription.new do |s|
        s.plan = plan
        s.email = email
        s.stripe_token = params[:stripeToken] if plan.amount > 0
        s.affiliate_id = affiliate.try(:id)
        s.currency = plan.respond_to?(:currency) ? plan.currency : Payola.default_currency
        s.coupon = params[:coupon]
        s.signed_custom_fields = params[:signed_custom_fields]
        s.setup_fee = params[:setup_fee]
        s.quantity = params[:quantity]
        s.trial_end = params[:trial_end]
        s.stripe_customer_id = customer.id if customer

        s.owner = owner
        s.amount = plan.amount
      end
      
      Payola.queue!(Payola::ProcessSubscription, sub.guid) if sub.save

      sub
    end
  end
end
