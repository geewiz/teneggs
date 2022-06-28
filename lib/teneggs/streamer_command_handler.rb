# frozen_string_literal: true

module Teneggs
  class StreamerCommandHandler < Twitch::Bot::EventHandler
    def self.handled_events
      [:user_message]
    end

    def call
      if event.command? && command_aliases.include?(event.command)
        handle_command
      end
    end

    private

    def command_aliases
      %w[streamer]
    end

    def handle_command
      args = event.command_args
      subcommand = args.shift
      if subcommand == "add"
        if authorized?
          user = args.shift
          streamers = Data::Streamers.new(client: client)
          streamers.add(user)
        else
          client.send_message "Permission denied."
        end
      elsif subcommand == "rm"
        if authorized?
          user = args.shift
          streamers = Data::Streamers.new(client: client)
          streamers.remove(user)
        else
          client.send_message "Permission denied."
        end
      end
    end

    def authorized?
      event.user == client.channel.name
    end
  end
end
