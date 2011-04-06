$:.unshift File.dirname(__FILE__)
require 'ruby_forge'

apps = Rack::URLMap.new(
  '/'  => RubyForgeApp
)

use Rack::Static, :urls => [ '/favicon.ico' ], :root => 'public'

run apps