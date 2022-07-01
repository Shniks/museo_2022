require './lib/photograph'
require './lib/artist'
require 'csv'

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

  def photographs_taken_by_artist_from(country)
    country_photos = []
    artists.each do |artist|
      check_the_artists_country(artist, country, country_photos)
    end
    country_photos.flatten
  end

  def check_the_artists_country(artist, country, country_photos)
    if artist.country == country
      country_photos << find_photographs_by_artist(artist)
    end
  end

  def load_photographs(file)
    CSV.foreach(file, headers:true) do |line|
      element = ({id: line[0], name: line[1], artist_id: line[2], year: line[3]})
      photo = Photograph.new(element)
      add_photograph(photo)
    end
  end

  def load_artists(file)
    CSV.foreach(file, headers:true) do |line|
      element = ({id: line[0], name: line[1], born: line[2], died: line[3], country: line[4]})
      artist = Artist.new(element)
      add_artist(artist)
    end
  end

  def photographs_taken_between(date_range)
    photographs.select do |photograph|
      date_range.include?(photograph.year.to_i)
    end
  end

  def artists_photographs_by_age(artist)
    artist_photos = find_photographs_by_artist(artist)
    photos_by_age = Hash.new
    find_photos_by_age(artist, photos_by_age, artist_photos)
    photos_by_age
  end

  def find_photos_by_age(artist, photos_by_age, artist_photos)
    artist_photos.each do |photo|
      photos_by_age[artist_age(photo, artist)] = photo.name
    end
  end

  def artist_age(photo, artist)
    photo.year.to_i - artist.born.to_i
  end

end
