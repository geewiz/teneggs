# frozen_string_literal: true

require "twitch/bot"
require "dotenv/load"
require_relative "teneggs/version"
require_relative "teneggs/join_handler"
require_relative "teneggs/subscription_handler"
require_relative "teneggs/plan_command_handler"
require_relative "teneggs/streamer_command_handler"
require_relative "teneggs/quote_command_handler"
require_relative "teneggs/defend_command_handler"
require_relative "teneggs/attack_command_handler"
require_relative "teneggs/shoutout_handler"
require_relative "teneggs/data/streamers"
require_relative "teneggs/data/user_cooldowns"

module Teneggs
  class Error < StandardError; end

  class Bot
    def initialize
      @client = Twitch::Bot::Client.new(
        channel: ENV["TWITCH_CHANNEL"],
        config: configuration,
      ) do
        register_handler(Teneggs::JoinHandler)
        register_handler(Teneggs::SubscriptionHandler)
        register_handler(Teneggs::PlanCommandHandler)
        register_handler(Teneggs::StreamerCommandHandler)
        register_handler(Teneggs::QuoteCommandHandler)
        register_handler(Teneggs::DefendCommandHandler)
        register_handler(Teneggs::AttackCommandHandler)
        register_handler(Teneggs::ShoutoutHandler)
      end
    end

    def run
      client.run
    end

    private

    attr_reader :client

    def adapter_class
      if development_mode?
        "Twitch::Bot::Adapter::Terminal"
      else
        "Twitch::Bot::Adapter::Irc"
      end
    end

    def configuration
      Twitch::Bot::Config.new(
        settings: {
          botname: ENV["TWITCH_USERNAME"],
          irc: {
            nickname: ENV["TWITCH_USERNAME"],
            password: ENV["TWITCH_PASSWORD"],
          },
          adapter: adapter_class,
          memory: "Twitch::Bot::Memory::Redis",
          log: {
            file: logfile,
            level: loglevel,
          },
        },
      )
    end

    def logfile
      if ENV["BOT_LOGFILE"]
        File.new(ENV["BOT_LOGFILE"], "w")
      else
        STDOUT
      end
    end

    def loglevel
      (ENV["BOT_LOGLEVEL"] || "info").to_sym
    end

    def development_mode?
      ENV["BOT_MODE"] == "development"
    end
  end
end
