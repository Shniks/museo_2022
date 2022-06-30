require './lib/photograph'
require './lib/artist'
require 'pry'

class Curator

  attr_reader :photographs

  def initialize
    @photographs = []
  end

  def add_photograph(photo)
    photographs << photo
  end




end
