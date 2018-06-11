require 'pry'

class Pokemon
    database_connection = SQLite3::Database.new('db/pokemon.db')

    attr_accessor :name, :type, :db, :id, :hp

    def initialize(id:, name:, type:, db:, hp: nil)
        @id = id
        @hp = hp
        @name = name
        @type = type
        @db = db
    end

    def self.all
        @@all
    end

    def self.save(name, type, database_connection)
        database_connection.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
    end
    
     def self.find(id, database_connection)
        poke_array = database_connection.execute("SELECT * FROM pokemon WHERE id=(?)", id).flatten
        pokemon = Pokemon.new(id: id, name: poke_array[1], type: poke_array[2], db: "pokemon", hp: poke_array[3])
        pokemon
        
     end

     def alter_hp(new_hp, database_connection)
        database_connection.execute("UPDATE pokemon SET hp=(?) WHERE id=(?)", new_hp, self.id)
        self.hp = new_hp
        self
     end

end
