# frozen_string_literal: true

RSpec.describe Teneggs::StreamerCommandHandler do
  it "adds a streamer" do
    message = Twitch::Bot::Message::UserMessage.new(
      text: "!streamer add friend",
      user: "testchannel",
    )
    config = Twitch::Bot::Config.new(
      settings: {
        bot_name: "test",
      },
    )
    client = Twitch::Bot::Client.new(config: config, channel: "testchannel")
    allow(client).to receive(:send_message)
    streamers = Teneggs::Data::Streamers.new(client: client)
    streamers.remove("friend")

    described_class.new(event: message, client: client).call

    expect(streamers.exists?("friend")).to be true
  end

  it "removes a streamer" do
    message = Twitch::Bot::Message::UserMessage.new(
      text: "!streamer rm friend",
      user: "testchannel",
    )
    config = Twitch::Bot::Config.new(
      settings: {
        bot_name: "test",
      },
    )
    client = Twitch::Bot::Client.new(config: config, channel: "testchannel")
    allow(client).to receive(:send_message)
    streamers = Teneggs::Data::Streamers.new(client: client)
    streamers.add("friend")

    described_class.new(event: message, client: client).call

    expect(streamers.exists?("friend")).to be false
  end
end
