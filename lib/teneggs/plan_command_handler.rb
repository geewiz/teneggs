# frozen_string_literal: true

module Teneggs
  # This class implements the !plan command.
  class PlanCommandHandler < Twitch::Bot::EventHandler
    def self.handled_events
      [:user_message]
    end

    def call
      if event.command? && command_aliases.include?(event.command)
        handle_plan_command
      end
    end

    private

    PLAN_FILE = File.expand_path("~/.plan")

    def command_aliases
      %w[plan project]
    end

    def handle_plan_command
      args = event.command_args
      subcommand = args.shift
      if subcommand == "set"
        if update_allowed?
          plan = args.join(" ")
          update_plan(plan)
        else
          client.send_message "Permission denied."
        end
      else
        announce_plan
      end
    end

    def update_allowed?
      event.user == client.channel.name
    end

    def update_plan(plan)
      client.memory.store("plan", plan)
      client.send_message "Plan set to '#{plan}'"
    end

    def announce_plan
      plan = client.memory.retrieve("plan")
      client.send_message "#{client.channel.name}'s plan: #{plan}"
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
