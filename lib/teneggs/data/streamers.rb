# frozen_string_literal: true

module Teneggs
  module Data
    class Streamers
      def initialize(client:)
        @client = client
      end

      def exists?(user)
        friends = retrieve_friends
        friends.key?(user)
      end

      def add(user)
        friends = retrieve_friends
        friends[user] = true
        store_friends(friends)
      end

      def remove(user)
        friends = retrieve_friends
        friends.delete(user)
        store_friends(friends)
      end

      private

      MEMORY_KEY = "streamer_friends"

      def retrieve_friends
        @client.memory.retrieve(MEMORY_KEY) || Hash.new
      end

      def store_friends(friends)
        @client.memory.store(MEMORY_KEY, friends)
      end
    end
  end
end
