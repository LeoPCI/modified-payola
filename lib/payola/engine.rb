module Payola
  class Engine < ::Rails::Engine
    isolate_namespace Payola
    engine_name 'payola'
    require_relative '../../app/helpers/payola/price_helper.rb'
    require_relative '../../app/services/payola/invoice_paid.rb'
    require_relative '../../app/services/payola/invoice_failed.rb'
    require_relative '../../app/services/payola/sync_subscription.rb'
    require_relative '../../app/services/payola/subscription_deleted.rb'

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.assets false
      g.helper false
    end

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end

    initializer :inject_helpers do |app|
      ActiveSupport.on_load :action_controller do
        ::ActionController::Base.send(:helper, Payola::PriceHelper)
      end

      ActiveSupport.on_load :action_mailer do
        ::ActionMailer::Base.send(:helper, Payola::PriceHelper)
      end
    end

    initializer :configure_subscription_listeners do |app|
      Payola.configure do |config|
        config.subscribe 'invoice.payment_succeeded',     Payola::InvoicePaid.to_proc
        config.subscribe 'invoice.payment_failed',        Payola::InvoiceFailed.to_proc
        config.subscribe 'customer.subscription.updated', Payola::SyncSubscription.to_proc
        config.subscribe 'customer.subscription.deleted', Payola::SubscriptionDeleted.to_proc
      end
    end
  end
end
