require 'pry'

class Pokemon

  attr_accessor :name, :type, :db, :id, :hp

  def initialize(name:, type:, db:, id:, hp:nil)
    @name = name
    @type = type
    @db = db
    @id = id
    @hp = hp
  end

  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
  end

  def self.find(id, db)
    pokemon_array = db.execute("SELECT * FROM pokemon WHERE id = ?", id).flatten

    Pokemon.new(name: pokemon_array[1], type: pokemon_array[2], db: db, id: id, hp: pokemon_array[3])

  end

  def alter_hp(hp, db)
    db.execute("UPDATE pokemon SET hp = ? WHERE id = ?", hp, self.id)
  end


end
