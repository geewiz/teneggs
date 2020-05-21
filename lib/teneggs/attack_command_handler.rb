# frozen_string_literal: true

module Teneggs
  # Implements the !defend command
  class AttackCommandHandler < Twitch::Bot::CommandHandler
    def initialize(event:, client:)
      super
      command_alias("attack")
    end

    private

    def handle_command
      client.send_message(response_text)
    end

    def response_text
      user = "@#{event.user}"
      [
        "#{user} is running nmap on our firewall!",
        "We're getting scanned by #{user}!",
        "#{user} tries to log into our bastion host!",
        "WARNING: #{user} is compiling malicious code!",
        "Unauthorized access by #{user}!",
        "#{user} ACCESS DENIED.",
        "Incorrect credentials submitted by user #{user}",
      ].sample
    end
  end
end
