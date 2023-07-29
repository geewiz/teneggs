# frozen_string_literal: true

module Teneggs
  # This class implements the !plan command.
  class PlanCommandHandler < Twitch::Bot::CommandHandler
    def command_aliases
      ["plan", "project"]
    end

    private

    def handle_command
      args = event.command_args
      subcommand = args.shift
      if subcommand == "set"
        if update_allowed?
          plan = args.join(" ")
          update_plan(plan)
        else
          client.send_message "@#{event.user} Permission denied."
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
  end
end
