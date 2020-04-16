# frozen_string_literal: true

require "twitch/bot"
require_relative "teneggs/version"
require_relative "teneggs/plan_command_handler"
require_relative "teneggs/quote_command_handler"

module Teneggs
  class Error < StandardError; end
end
