Synchromesh.configuration do |config|
  config.transport = :simple_poller
  config.channel_prefix = "synchromesh"
  config.opts = {
    seconds_between_poll: 1.second,
    seconds_polled_data_will_be_retained: 1.hour
  }

  # config.transport = :pusher
  # config.opts = {
  #   app_id: '233769',
  #   key:    '36dc6310d01189a720ab',
  #   secret: '70aa2b879636659c92d7',
  #   encrypted: false
  # }
  # config.channel_prefix = 'syncromesh'

end
