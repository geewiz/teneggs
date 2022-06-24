# frozen_string_literal: true

module Teneggs
  class ShoutoutHandler < Twitch::Bot::EventHandler
    def self.handled_events
      [:user_message]
    end

    def call
      return unless streamer_friend?(event.user)

      unless shoutout_cooldown?(event.user)
        shoutout(event.user)
      end
      update_last_seen(user: event.user)
    end

    private

    COOLDOWN_PERIOD = 3600

    def shoutout(user)
      client.send_message "Shoutout to #{user}!"
    end

    def shoutout_cooldown?(user)
      last_seen_time = last_seen(user)
      !last_seen_time.nil? && last_seen_time > Time.now - COOLDOWN_PERIOD
    end

    def retrieve_last_seen_data
      client.memory.retrieve("last_seen") || Hash.new
    end

    def store_last_seen_data(last_seen_data)
      client.memory.store("last_seen", last_seen_data)
    end

    def last_seen(user)
      last_seen_data = retrieve_last_seen_data
      last_seen_data[user]
    end

    def update_last_seen(user)
      last_seen_data = retrieve_last_seen_data
      last_seen_data[user] = Time.now
      store_last_seen_data(last_seen_data)
    end

    def retrieve_friends
      client.memory.retrieve("streamer_friends") || Hash.new
    end

    def streamer_friend?(user)
      friends = retrieve_friends
      friends.key?(user)
    end
  end
end
