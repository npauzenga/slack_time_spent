require 'spec_helper'
require 'commands/slacktrack'

describe SlackTrack do
  let(:team) { Fabricate(:team) }
  let(:app) { SlackRubyBotServer::Server.new(team: team) }
  let(:client) { app.send(:client) }
  let(:message_hook) { SlackRubyBot::Hooks::Message.new }

  context 'punch in' do
    it 'returns confirmation' do
      expect(message: "punch in", channel: 'channel', user: 'user').to respond_with_slack_message(
        "You've punched in"
      )
    end
  end

  context 'slacktrack' do
    it 'returns a message' do
      expect(message: "slacktrack", channel: 'channel', user: 'user').to respond_with_slack_message(
        "0 hours, 0 minutes, and 0 seconds"
      )
    end
  end

  context 'punch out' do
    it 'returns a message' do
      expect(message: "punch out", channel: 'channel', user: 'user').to respond_with_slack_message(
        "You punched out. You logged 0 hours, 0 minutes, and 0 seconds"
      )
    end
  end
end
