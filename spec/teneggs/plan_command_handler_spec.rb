# frozen_string_literal: true

RSpec.describe Teneggs::PlanCommandHandler do
  it "sends the contents of the .plan file" do
    message = Twitch::Bot::Message::UserMessage.new(
      text: "!plan",
      user: "tester",
    )
    client = Twitch::Bot::Client.new(connection: nil, channel: "testchannel")
    allow(client).to receive(:send_message)
    handler = described_class.new(event: message, client: client)
    allow(handler).to receive(:plan_file_content).and_return("Hello")

    handler.call

    expect(client).to have_received(:send_message).with("Hello")
  end
end
