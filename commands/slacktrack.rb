class SlackTrack < SlackRubyBot::Commands::Base
  def initialize
    @time_in = 0
    @time_out = 0
    @time_spent = 0
  end

  def format_time(seconds)
    minutes = 0

    while seconds >= 60
      minutes++
      seconds -= 60
    end

    return "#{minutes} minutes, and #{seconds} seconds"
  end

  match /^punch in$/ do |client, data, match|
    @time_in = Time.now
    client.say(channel: data.channel, text: "You've punched in")
  end

  match /^punch out$/ do |client, data, match|
    @time_out = Time.now
    @time_spent = @time_out - @time_in
    @time_in = 0

    client.say(channel: data.channel,
               text: "You punched out at #{@time_out}. You logged #{@time_spent.minute}")
  end

  match /^slacktrack$/ do |client, data, match|
    if @time_in == 0
      client.say(channel: data.channel, text: "log back in to resume tracking")
    else
      @time_spent = Time.now - @time_in
      client.say(channel: data.channel, text: (@time_spent.minute))
    end
  end
end
