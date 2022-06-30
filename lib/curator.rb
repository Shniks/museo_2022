require './lib/photograph'
require './lib/artist'
require 'pry'

class Curator

  attr_reader :photographs,
              :artists,
              :how_many_photos

  def initialize
    @photographs = []
    @artists = []
    @how_many_photos = Hash.new
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

  def find_photographs_by_artist(artist)
    photographs.select do |photo|
      photo.artist_id == artist.id
    end
  end

  def artists_with_multiple_photographs
    artists.map do |artist|
      all_artist_photos = find_photographs_by_artist(artist)
      how_many_photos[artist] = all_artist_photos.count
    end
    find_artists_with_more_than_two_photos
  end

  def find_artists_with_more_than_two_photos
    how_many_photos.select do |artist, value|
      value >= 2
    end.keys
  end







end
