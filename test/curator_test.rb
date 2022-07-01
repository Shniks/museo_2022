require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/curator'

class CuratorTest < Minitest::Test

  def test_if_it_exists
    curator = Curator.new

    assert_instance_of Curator, curator
  end

  def test_it_has_attributes
    curator = Curator.new

    assert_equal [], curator.photographs
    assert_equal [], curator.artists
  end

  def test_it_can_add_photographs
    curator = Curator.new
    photo_1 = Photograph.new({
                               id: "1",
                               name: "Rue Mouffetard, Paris (Boy with Bottles)",
                               artist_id: "1",
                               year: "1954"
                             })
    photo_2 = Photograph.new({
                               id: "2",
                               name: "Moonrise, Hernandez",
                               artist_id: "2",
                               year: "1941"
                             })
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)

    assert_equal [photo_1, photo_2], curator.photographs
  end

  def test_it_can_add_artists
    curator = Curator.new
    artist_1 = Artist.new({
                            id: "1",
                            name: "Henri Cartier-Bresson",
                            born: "1908",
                            died: "2004",
                            country: "France"
                          })
    artist_2 = Artist.new({
                            id: "2",
                            name: "Ansel Adams",
                            born: "1902",
                            died: "1984",
                            country: "United States"
                          })
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)

    assert_equal [artist_1, artist_2], curator.artists
  end

  def test_it_can_find_artist_by_id
    curator = Curator.new
    artist_1 = Artist.new({
                            id: "1",
                            name: "Henri Cartier-Bresson",
                            born: "1908",
                            died: "2004",
                            country: "France"
                          })
    artist_2 = Artist.new({
                            id: "2",
                            name: "Ansel Adams",
                            born: "1902",
                            died: "1984",
                            country: "United States"
                          })
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    result = curator.find_artist_by_id("1")

    assert_equal artist_1, result
  end

  def test_it_can_find_a_photograph_by_id
    curator = Curator.new
    photo_1 = Photograph.new({
                               id: "1",
                               name: "Rue Mouffetard, Paris (Boy with Bottles)",
                               artist_id: "1",
                               year: "1954"
                             })
    photo_2 = Photograph.new({
                               id: "2",
                               name: "Moonrise, Hernandez",
                               artist_id: "2",
                               year: "1941"
                             })
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    result = curator.find_photograph_by_id("2")

    assert_equal photo_2, result
  end

  def test_it_can_find_all_the_photos_of_an_artist
    curator = Curator.new
    photo_1 = Photograph.new({
                               id: "1",
                               name: "Rue Mouffetard, Paris (Boy with Bottles)",
                               artist_id: "1",
                               year: "1954"
                              })
    photo_2 = Photograph.new({
                               id: "2",
                               name: "Moonrise, Hernandez",
                               artist_id: "2",
                               year: "1941"
                              })
    photo_3 = Photograph.new({
                               id: "3",
                               name: "Identical Twins, Roselle, New Jersey",
                               artist_id: "3",
                               year: "1967"
                              })
    photo_4 = Photograph.new({
                               id: "4",
                               name: "Monolith, The Face of Half Dome",
                               artist_id: "3",
                               year: "1927"
                              })
    artist_1 = Artist.new({
                               id: "1",
                               name: "Henri Cartier-Bresson",
                               born: "1908",
                               died: "2004",
                               country: "France"
                              })
    artist_2 = Artist.new({
                               id: "2",
                               name: "Ansel Adams",
                               born: "1902",
                               died: "1984",
                               country: "United States"
                              })
    artist_3 = Artist.new({
                               id: "3",
                               name: "Diane Arbus",
                               born: "1923",
                               died: "1971",
                               country: "United States"
                              })

    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)

    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)

    result = curator.find_photographs_by_artist(artist_3)

    assert_equal [photo_3, photo_4], result
  end

  def test_it_can_find_artists_with_multiple_photographs
    curator = Curator.new
    photo_1 = Photograph.new({
                               id: "1",
                               name: "Rue Mouffetard, Paris (Boy with Bottles)",
                               artist_id: "1",
                               year: "1954"
                              })
    photo_2 = Photograph.new({
                               id: "2",
                               name: "Moonrise, Hernandez",
                               artist_id: "2",
                               year: "1941"
                              })
    photo_3 = Photograph.new({
                               id: "3",
                               name: "Identical Twins, Roselle, New Jersey",
                               artist_id: "3",
                               year: "1967"
                              })
    photo_4 = Photograph.new({
                               id: "4",
                               name: "Monolith, The Face of Half Dome",
                               artist_id: "3",
                               year: "1927"
                              })
    artist_1 = Artist.new({
                               id: "1",
                               name: "Henri Cartier-Bresson",
                               born: "1908",
                               died: "2004",
                               country: "France"
                              })
    artist_2 = Artist.new({
                               id: "2",
                               name: "Ansel Adams",
                               born: "1902",
                               died: "1984",
                               country: "United States"
                              })
    artist_3 = Artist.new({
                               id: "3",
                               name: "Diane Arbus",
                               born: "1923",
                               died: "1971",
                               country: "United States"
                              })

    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)

    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)

    result = curator.artists_with_multiple_photographs

    assert_equal [artist_3], result
  end

  def test_it_can_find_photographs_taken_by_country
    curator = Curator.new
    photo_1 = Photograph.new({
                               id: "1",
                               name: "Rue Mouffetard, Paris (Boy with Bottles)",
                               artist_id: "1",
                               year: "1954"
                              })
    photo_2 = Photograph.new({
                               id: "2",
                               name: "Moonrise, Hernandez",
                               artist_id: "2",
                               year: "1941"
                              })
    photo_3 = Photograph.new({
                               id: "3",
                               name: "Identical Twins, Roselle, New Jersey",
                               artist_id: "3",
                               year: "1967"
                              })
    photo_4 = Photograph.new({
                               id: "4",
                               name: "Monolith, The Face of Half Dome",
                               artist_id: "3",
                               year: "1927"
                              })
    artist_1 = Artist.new({
                               id: "1",
                               name: "Henri Cartier-Bresson",
                               born: "1908",
                               died: "2004",
                               country: "France"
                              })
    artist_2 = Artist.new({
                               id: "2",
                               name: "Ansel Adams",
                               born: "1902",
                               died: "1984",
                               country: "United States"
                              })
    artist_3 = Artist.new({
                               id: "3",
                               name: "Diane Arbus",
                               born: "1923",
                               died: "1971",
                               country: "United States"
                              })

    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)

    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)

    result_1 = curator.photographs_taken_by_artist_from("United States")
    result_2 = curator.photographs_taken_by_artist_from("Argentina")

    assert_equal [photo_2, photo_3, photo_4], result_1
    assert_equal [], result_2
  end

  def test_if_it_can_load_photographs_from_a_file
    curator = Curator.new
    curator.load_photographs('./data/photographs.csv')

    assert_instance_of Photograph, curator.photographs[0]
    assert_equal 4, curator.photographs.count
  end

  def test_if_it_can_load_artists_from_a_file
    curator = Curator.new
    curator.load_artists('./data/artists.csv')

    assert_instance_of Artist, curator.artists[0]
    assert_equal 6, curator.artists.count
  end

  def test_if_it_can_find_photographs_in_a_date_range
    curator = Curator.new
    curator.load_photographs('./data/photographs.csv')
    curator.load_artists('./data/artists.csv')
    result = curator.photographs_taken_between(1950..1965)

    assert_equal 2, result.count
    assert_instance_of Photograph, result[0]
  end

end
