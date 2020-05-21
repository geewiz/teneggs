# frozen_string_literal: true

module Teneggs
  # Implements the !defend command
  class DefendCommandHandler < Twitch::Bot::CommandHandler
    def initialize(event:, client:)
      super
      command_alias("defend")
      command_alias("defense")
    end

    private

    def handle_command
      client.send_message("@#{event.user}, #{response_text}")
    end

    def response_text
      [
        "reconfiguring firewall.",
        "fail2ban enabled.",
        "encrypting sensitive files.",
        "dialup lines shut down.",
        "scanning logs...",
        "Intrusion Detection System started.",
        "refreshing API tokens.",
        "reshuffling BGP tables.",
        "honeypot enabled.",
        "switching to backup power.",
        "going to DEFCON-1!",
        "shredding incriminating documents.",
        "fallback to secondary data centre initiated.",
        "syncing tape archive.",
        "alerting on-call staff.",
      ].sample
    end
  end
end
