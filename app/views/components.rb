# app/views/components.rb
require 'opal'
require 'webpack/client_and_server.js'
require 'reactrb'
require 'reactrb/auto-import'
if React::IsomorphicHelpers.on_opal_client?
  require 'opal-jquery'
  require 'browser'
  require 'browser/interval'
  require 'browser/delay'
  require 'opal_hot_reloader'
  require 'synchromesh'
  OpalHotReloader.listen(25222, true)
  # add any additional requires that can ONLY run on client here
end
require 'reactive-record'
require '_react_public_models'

require_tree './components'
