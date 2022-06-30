# require './lib/photograph'
require './lib/artist'
require 'pry'

class Curator

  attr_reader :photographs,
              :artists

  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(photo)
    photographs << photo
  end

  def add_artist(artist)
    artists << artist
  end

  def find_artist_by_id(id)
    artists.find { |artist| id == artist.id }
  end

  def find_photograph_by_id(id)
    photographs.find { |photograph| id == photograph.id }
  end

end
