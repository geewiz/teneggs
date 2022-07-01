# frozen_string_literal: true

module Teneggs
  class StreamerCommandHandler < Twitch::Bot::CommandHandler
    def initialize(event:, client:)
      super
      command_alias "streamer"
    end

    private

    def handle_command
      return unless authorized?

      args = event.command_args
      subcommand = args.shift
      if subcommand == "add"
        add_streamer(args.shift)
      elsif subcommand == "rm"
        remove_streamer(args.shift)
      end
    end

    def authorized?
      event.user == client.channel.name
    end

    def add_streamer(user)
      streamers = Data::Streamers.new(client: client)
      streamers.add(user)
      client.send_message "Added #{user} to the streamer list."
    end

    def remove_streamer(user)
      streamers = Data::Streamers.new(client: client)
      streamers.remove(user)
      client.send_message "Removed #{user} from the streamer list."
    end
  end
end
