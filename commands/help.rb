class Help < SlackRubyBot::Commands::Base
  HELP = <<-EOS.freeze
```
I am your friendly time-tracking bot, here to help.

General
-------

help               - get this helpful message
whoami             - print your username
punch in           - start tracking your time on Slack
punch out          - stop tracking your time on Slack
slacktrack         - display the time you've spent on slack so far

```
EOS
  def self.call(client, data, _match)
    client.say(channel: data.channel, text: [HELP, SlackRubyBotServer::INFO].join("\n"))
    client.say(channel: data.channel, gif: 'help')
    logger.info "HELP: #{client.owner}, user=#{data.user}"
  end
end
