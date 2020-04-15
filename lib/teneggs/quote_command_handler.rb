# frozen_string_literal: true

module Teneggs
  # This class handles the !quote command
  class QuoteCommandHandler < Twitch::Bot::EventHandler
    def self.handled_events
      [:user_message]
    end

    def call
      if event.command_name?("quote")
        client.send_message quote_text
      end
    end

    private

    QUOTES = {
      "wizard" => <<~QUOTE,
        "Do not meddle in the affairs of wizards, for they are subtle and quick to anger." -- J.R.R. Tolkien, The Fellowship of the Ring
      QUOTE
      "seniorasshole" => <<~QUOTE,
        "If you can't forgive a junior admitting a mistake, you are no longer a senior developer but a senior asshole." -- FullStackLive 2020-04-15
      QUOTE
    }.freeze

    def quote_text
      quote = event.command_args.first
      if quote
        QUOTES[quote]
      else
        "Quote name missing!"
      end
    end
  end
end
