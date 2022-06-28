# frozen_string_literal: true

module Teneggs
  module Data
    class UserCooldowns
      def initialize(client:, cooldown:)
        @client = client
        @cooldown = cooldown
      end

      def expired?(user:, duration:)
        last_seen_data = retrieve_last_seen_data
        last_seen = last_seen_data[memory_cell(user)]
        last_seen.nil? || last_seen < Time.now - duration
      end

      def start(user)
        last_seen_data = retrieve_last_seen_data
        last_seen_data[memory_cell(user)] = Time.now
        store_last_seen_data(last_seen_data)
      end

      def clear(user)
        last_seen_data = retrieve_last_seen_data
        last_seen_data.delete(memory_cell(user: user))
        store_last_seen_data(last_seen_data)
      end

      private

      MEMORY_KEY = "user_cooldown"

      def memory_cell(user)
        "#{user}::#{@cooldown}"
      end

      def retrieve_last_seen_data
        @client.memory.retrieve(MEMORY_KEY) || Hash.new
      end

      def store_last_seen_data(last_seen_data)
        @client.memory.store(MEMORY_KEY, last_seen_data)
      end
    end
  end
end
