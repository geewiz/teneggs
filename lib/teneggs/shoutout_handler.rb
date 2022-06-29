# frozen_string_literal: true

module Teneggs
  class ShoutoutHandler < Twitch::Bot::EventHandler
    def self.handled_events
      [:user_message]
    end

    def call
      streamers = Data::Streamers.new(client: client)
      return unless streamers.exists?(event.user)

      cooldown = Data::UserCooldowns.new(client: client, cooldown: "shoutout")
      if cooldown.expired?(user: event.user, duration: COOLDOWN_PERIOD)
        shoutout(event.user)
        cooldown.start(event.user)
      end
    end

    private

    COOLDOWN_PERIOD = 3600

    def shoutout(user)
      client.send_message "Make sure to follow @#{user}, "\
                          "one of #{client.channel.name}'s favourite "\
                          "streamers! https://www.twitch.tv/#{user}"
    end
  end
end
