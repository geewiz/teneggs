# frozen_string_literal: true

RSpec.describe Teneggs::DefendCommandHandler do
  it "responds with a random defense" do
    message = Twitch::Bot::Message::UserMessage.new(
      text: "!defend",
      user: "tester",
    )
    config = Twitch::Bot::Config.new(
      settings: {
        bot_name: "test",
      },
    )
    client = Twitch::Bot::Client.new(config: config, channel: "testchannel")
    allow(client).to receive(:send_message)
    handler = described_class.new(event: message, client: client)
    allow(handler).to receive(:response_text).and_return("Ha!")

    handler.call

    expect(client).to have_received(:send_message).
      with("Ha!")
  end
end
