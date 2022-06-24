# frozen_string_literal: true

RSpec.describe Teneggs::ShoutoutHandler do
  it "gives a shoutout to friends who joined the chat" do
    config = Twitch::Bot::Config.new(
      settings: {
        bot_name: "test",
      },
    )
    client = Twitch::Bot::Client.new(config: config, channel: "testchannel")
    allow(client).to receive(:send_message)
    client.memory.store("streamer_friends", { "friend" => true })
    client.memory.store("last_seen", { "friend" => Time.now - 86400 })
    message = Twitch::Bot::Message::UserMessage.new(
      text: "hello",
      user: "friend",
    )

    described_class.new(event: message, client: client).call

    expect(client).to have_received(:send_message).
      with("Shoutout to friend!")
  end

  it "skips shoutout to chatty friends" do
    config = Twitch::Bot::Config.new(
      settings: {
        bot_name: "test",
      },
    )
    client = Twitch::Bot::Client.new(config: config, channel: "testchannel")
    allow(client).to receive(:send_message)
    client.memory.store("streamer_friends", { "friend" => true })
    client.memory.store("last_seen", { "friend" => Time.now - 30 })
    message = Twitch::Bot::Message::UserMessage.new(
      text: "hello",
      user: "friend",
    )

    described_class.new(event: message, client: client).call

    expect(client).not_to have_received(:send_message).
      with("Shoutout to friend!")
  end

  it "does not shout to non-friends" do
    config = Twitch::Bot::Config.new(
      settings: {
        bot_name: "test",
      },
    )
    client = Twitch::Bot::Client.new(config: config, channel: "testchannel")
    allow(client).to receive(:send_message)
    client.memory.store("streamer_friends", { "friend" => true })
    client.memory.store("last_seen", { "nonfriend" => Time.now - 86400 })
    message = Twitch::Bot::Message::UserMessage.new(
      text: "hello",
      user: "nonfriend",
    )

    described_class.new(event: message, client: client).call

    expect(client).not_to have_received(:send_message).
      with("Shoutout to nonfriend!")
  end
end
