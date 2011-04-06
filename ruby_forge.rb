require 'uri'
require 'erb'
require 'httparty'

class RubyForge
  include HTTParty
  base_uri 'api.rubyforge.org'
  basic_auth ENV['RUBYFORGE_USERNAME'], ENV['RUBYFORGE_PASSWORD']

  def self.user user
    self.get("/users/#{user}")['user']
  end
end

require 'camping'

Camping.goes :RubyForgeApp

module RubyForgeApp
  set :views, File.dirname(__FILE__) + '/views'
end

module RubyForgeApp::Controllers
  class Index < R '/'
    include ERB::Util
    RUBYHIPSTER = { 'user_id' => 1, 'user_name' => 'rubyhipster', 'realname' => 'Ruby Hipster' }
    def get
      @user = if @input.user
        if ['rubyhipster', '1',].include? @input.user
          RUBYHIPSTER
        else
          RubyForge.user @input.user
        end
      end
      render :index
    end
  end
end
