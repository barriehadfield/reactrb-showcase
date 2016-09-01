Synchromesh.configuration do |config|
  config.transport = :simple_poller
  config.channel_prefix = "synchromesh"
  config.opts = {
    seconds_between_poll: 1.second,
    seconds_polled_data_will_be_retained: 1.hour
  }

  # config.transport = :pusher
  # config.opts = {
  #   app_id: 'xxx',
  #   key:    'xxx',
  #   secret: 'xxx',
  #   encrypted: false
  # }
  # config.channel_prefix = 'syncromesh'
end
