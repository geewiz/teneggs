# frozen_string_literal: true

RSpec.describe Teneggs::PlanCommandHandler do
  it "responds with the current plan" do
    message = Twitch::Bot::Message::UserMessage.new(
      text: "!plan",
      user: "tester",
    )
    config = Twitch::Bot::Config.new(
      settings: {
        bot_name: "test",
      },
    )
    client = Twitch::Bot::Client.new(config: config, channel: "testchannel")
    allow(client).to receive(:send_message)
    client.memory.store("plan", "Hello")
    handler = described_class.new(event: message, client: client)

    handler.call

    expect(client).to have_received(:send_message).
      with("testchannel's plan: Hello")
  end

  it "updates the current plan for the owner" do
    config = Twitch::Bot::Config.new(
      settings: {
        bot_name: "test",
      },
    )
    client = Twitch::Bot::Client.new(config: config, channel: "testchannel")
    message = Twitch::Bot::Message::UserMessage.new(
      text: "!plan set This is a test.",
      user: "testchannel",
    )
    handler = described_class.new(event: message, client: client)
    allow(client).to receive(:send_message)

    handler.call

    expect(client).to have_received(:send_message).
      with("Plan set to 'This is a test.'")
  end

  it "does not update the current plan for anyone else" do
    config = Twitch::Bot::Config.new(
      settings: {
        bot_name: "test",
      },
    )
    client = Twitch::Bot::Client.new(config: config, channel: "testchannel")
    message = Twitch::Bot::Message::UserMessage.new(
      text: "!plan set This is a test.",
      user: "someoneelse",
    )
    handler = described_class.new(event: message, client: client)
    allow(client).to receive(:send_message)

    handler.call

    expect(client).to have_received(:send_message).
      with("Permission denied.")
  end
end
