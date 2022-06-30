class Artist

  attr_reader :id,
              :name,
              :born,
              :died,
              :country

  def initialize(artist)
    @id = artist[:id]
    @name = artist[:name]
    @born = artist[:born]
    @died = artist[:died]
    @country = artist[:country]
  end

end
