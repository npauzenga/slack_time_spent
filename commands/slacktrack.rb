class SlackTrack < SlackRubyBot::Commands::Base
  def initialize
    @time_in = 0
    @time_out = 0
    @time_spent = 0
  end

  command 'punchin' do |client, data, match|
    @time_in = Time.now
    client.say(channel: data.channel, text: "You've punched in")
  end

  command 'punchout' do |client, data, match|
    @time_out = Time.now
    @time_spent = @time_out - @time_in
    @time_in = 0

    client.say(channel: data.channel,
               text: "You punched out at #{@time_out}. You logged #{@time_spent.days} days, #{@time_spent.hour} hours, #{@time_spent.minute} minutes, and #{@time_spent.second} seconds")
  end

  command 'slacktrack' do |client, data, match|
    if @time_in == 0 || @time_in == nil
      client.say(channel: data.channel, text: "log in to resume tracking")
    else
      @time_spent = Time.now - @time_in
      client.say(channel: data.channel, text: "You logged #{@time_spent.days} days, #{@time_spent.hour} hours, #{@time_spent.minute} minutes, and #{@time_spent.second} seconds")
    end
  end
end
