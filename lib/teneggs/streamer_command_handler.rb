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
        client.send_message "Processing add..."
        if authorized?
          user = args.shift
          streamers = Data::Streamers.new(client: client)
          streamers.add(user)
          client.send_message "Added #{user} to the streamer list."
        else
          client.send_message "Permission denied."
        end
      elsif subcommand == "rm"
        client.send_message "Processing remove..."
        if authorized?
          user = args.shift
          streamers = Data::Streamers.new(client: client)
          streamers.remove(user)
          client.send_message "Removed #{user} from the streamer list."
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
