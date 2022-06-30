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
    artists.find do |artist|
      id == artist.id
    end
  end




end
