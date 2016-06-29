class SlackTrack < SlackRubyBot::Commands::Base
  def initialize
    @time_in = 0
    @time_out = 0
    @time_spent = 0
  end

  # Returns a pretty-printed version of the time based on elapsed seconds.
  def self.format_time(seconds)
    minutes = 0

    while seconds >= 60
      minutes += 1
      seconds -= 60
    end

    return "#{minutes} minutes, and #{seconds.round} seconds"
  end

  # run with "punch in". If timespent bot is present, it will set your time_in and
  # respond with a confirmation
  match /^punch in$/ do |client, data, match|
    @time_in = Time.now
    client.say(channel: data.channel, text: "You've punched in")
  end

  # run with "punch out". If timespent bot is present, it will respond with
  # your total time logged in this session an reset your time_in
  match /^punch out$/ do |client, data, match|
    @time_out = Time.now
    @time_spent = @time_out - @time_in
    @time_in = 0

    client.say(channel: data.channel,
               text: "You punched out. You logged #{SlackTrack.format_time(@time_spent)}")
  end

  # run with "slacktrack", If timespent bot is present, it will respond with
  # your total time logged in this session
  match /^slacktrack$/ do |client, data, match|
    if @time_in == 0 || @time_in == nil
      client.say(channel: data.channel, text: "log in to resume tracking")
    else
      @time_spent = Time.now - @time_in
      client.say(channel: data.channel, text: SlackTrack.format_time(@time_spent))
    end
  end
end
