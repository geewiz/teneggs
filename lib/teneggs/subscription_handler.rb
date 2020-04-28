# frozen_string_literal: true

module Teneggs
  class SubscriptionHandler < Twitch::Bot::EventHandler
    def call
      client.send_message "Hi #{event.user}, thank you for your subscription"
    end

    def self.handled_events
      [:subscription]
    end
  end
end
