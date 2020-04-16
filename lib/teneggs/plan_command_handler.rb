# frozen_string_literal: true

module Teneggs
  # This class implements the !plan command.
  class PlanCommandHandler < Twitch::Bot::EventHandler
    def self.handled_events
      [:user_message]
    end

    def call
      if event.command? && command_aliases.include?(event.command)
        output_plan_file
      end
    end

    private

    PLAN_FILE = File.expand_path("~/.plan")

    def command_aliases
      %w[plan project]
    end

    def output_plan_file
      client.send_message plan_file_content
    end

    def plan_file_content
      if File.exist?(PLAN_FILE)
        File.read(PLAN_FILE)
      else
        "Error: Plan file missing!"
      end
    end
  end
end
