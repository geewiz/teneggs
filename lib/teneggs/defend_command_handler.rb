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
      client.send_message(response_text)
    end

    def response_text
      [
        "iptables -A INPUT -p tcp -s twitch.tv --dport 22 -j DROP",
        "service fail2ban start",
        "Encrypting sensitive files...",
        "Down dialup lines shut down.",
        "Scanning logs...",
        "Intrusion Detection System started.",
        "Refreshing API tokens...",
        "Reshuffling BGP tables...",
        "Honeypot enabled.",
        "Switching to backup power.",
        "Going to DEFCON-1.",
        "Shredding incriminating documents...",
        "Fallback to secondary data centre initiated.",
        "Calling up tape archives.",
        "Alerting on-call staff...",
      ].sample
    end
  end
end
