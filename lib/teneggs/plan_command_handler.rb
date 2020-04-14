# frozen_string_literal: true

module Teneggs
  class PlanCommandHandler < Twitch::Bot::EventHandler
    def self.handled_events
      [:chat_message]
    end

    def call
      if event.bot_command?("plan")
        output_plan_file
      end
    end

    private

    PLAN_FILE_PATH = File.expand_path("~/.plan")

    def output_plan_file
      client.send_message plan_file_content
    end

    def plan_file_content
      if File.exist?(PLAN_FILE_PATH)
        File.read(PLAN_FILE_PATH)
      end
    end
  end
end
