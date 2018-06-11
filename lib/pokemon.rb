#COMPLTED BY ANTHONY AND JARED


require 'pry'
class Pokemon

    attr_accessor :id, :name, :type, :hp, :db

    @@all = []

    def initialize(id:, name:, type:, db:, hp:nil)
        @id = id
        @name = name
        @type = type
        @db = db
        @hp = hp
        @@all << self
    end

    def self.all
        @@all
    end

    def self.save(name, type, db)
        db.execute("INSERT INTO pokemon (name, type) VALUES(?, ?);", name, type)
    end

    def self.find(id, db)
        pokemon_in_db = db.execute("SELECT * FROM pokemon WHERE id = ?;", id).flatten

        new_pokemon = Pokemon.new(id: id, name: pokemon_in_db[1],type: pokemon_in_db[2], db: db, hp: pokemon_in_db[3])
    end

    def alter_hp(new_hp, db)
        db.execute("UPDATE pokemon SET hp = ? WHERE id = ?",new_hp, self.id)
        self.hp = new_hp
    end
end
