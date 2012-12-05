# env.rb
require 'simplecov'

require 'rubygems'

class KelpWorld
  def self.root_dir
    @root_dir ||= File.join(File.expand_path(File.dirname(__FILE__)), '..', '..')
  end

  def root_dir
    KelpWorld.root_dir
  end
end

World do
  KelpWorld.new
end

