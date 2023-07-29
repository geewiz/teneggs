# frozen_string_literal: true

module Teneggs
  # This class handles the !quote command
  class QuoteCommandHandler < Twitch::Bot::CommandHandler
    def command_aliases
      ["quote"]
    end

    private

    QUOTES = {
      "wizard" => <<~QUOTE,
        "Do not meddle in the affairs of wizards, for they are subtle and quick to anger." -- J.R.R. Tolkien, The Fellowship of the Ring
      QUOTE
      "seniorasshole" => <<~QUOTE,
        "If you can't forgive a junior admitting a mistake, you are no longer a senior engineer but a senior asshole." -- FullStackLive 2020-04-15
      QUOTE
      "comments" => <<~QUOTE,
        "https://clips.twitch.tv/MotionlessInexpensiveLeopardPermaSmug"
      QUOTE
    }.freeze

    def handle_command
      client.send_message quote_text
    end

    def quote_text
      quote_name = event.command_args.first
      if quote_name
        QUOTES[quote_name] || "Error: Quote not found."
      else
        "Error: Quote name missing!"
      end
    end
  end
end
