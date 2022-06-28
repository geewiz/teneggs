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
    Teneggs::Data::Streamers.new(client: client).add("friend")
    Teneggs::Data::UserCooldowns.new(client: client, cooldown: "shoutout").
      clear("friend")
    message = Twitch::Bot::Message::UserMessage.new(
      text: "hello",
      user: "friend",
    )

    described_class.new(event: message, client: client).call

    expect(client).to have_received(:send_message).
      with(/@friend/)
  end

  it "skips shoutout to chatty friends" do
    config = Twitch::Bot::Config.new(
      settings: {
        bot_name: "test",
      },
    )
    client = Twitch::Bot::Client.new(config: config, channel: "testchannel")
    allow(client).to receive(:send_message)
    Teneggs::Data::Streamers.new(client: client).add("friend")
    Teneggs::Data::UserCooldowns.new(client: client, cooldown: "shoutout").
      start("friend")
    message = Twitch::Bot::Message::UserMessage.new(
      text: "hello",
      user: "friend",
    )

    described_class.new(event: message, client: client).call

    expect(client).not_to have_received(:send_message).
      with(/@friend/)
  end

  it "does not shout to non-friends" do
    config = Twitch::Bot::Config.new(
      settings: {
        bot_name: "test",
      },
    )
    client = Twitch::Bot::Client.new(config: config, channel: "testchannel")
    allow(client).to receive(:send_message)
    Teneggs::Data::Streamers.new(client: client).remove("friend")
    Teneggs::Data::UserCooldowns.new(client: client, cooldown: "shoutout").
      clear("friend")
    message = Twitch::Bot::Message::UserMessage.new(
      text: "hello",
      user: "friend",
    )

    described_class.new(event: message, client: client).call

    expect(client).not_to have_received(:send_message).
      with(/@friend/)
  end
end
