# frozen_string_literal: true

module Teneggs
  class JoinHandler < Twitch::Bot::EventHandler
    def call
      client.send_message "READY."
    end

    def self.handled_events
      [:join]
    end
  end
end
