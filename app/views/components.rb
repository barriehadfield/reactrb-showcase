# app/react/components.rb
require 'opal'
require 'react'
require 'reactrb'
if React::IsomorphicHelpers.on_opal_client?
  require 'opal-jquery'
  require 'browser'
  require 'browser/interval'
  require 'browser/delay'
  # add any additional requires that can ONLY run on client here
end

require_tree './components'
