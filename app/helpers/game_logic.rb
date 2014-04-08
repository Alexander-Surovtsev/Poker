module GameLogic

  require 'singleton'
  
  class Player
    
    @nickname
    @email
    @money
    @id
    
    def initialize(id, name, email, money = 50000)
      @nickname = name
      @email = email
      @money = money
      @id = id
    end
    
    def getId
      @id
    end
    
    def getNickname
      @nickname
    end
  
  end
  
  class Room
    
    @id  #теперь id то же самое, что name
    @players
    @creatorId
    @messages
    
    def initialize(name, creatorId)
      @id = name  #теперь id то же самое, что name
      @players = Array.new
      @messages = Array.new
      @creatorId = creatorId
    end
    
    def hasPlayer(id)
      has = false
      @players.each do |player|
        if player.getId == id
          has = true
        end
      end
      has
    end
    
    def getNickById(id)
      nick = ""
      @players.each do |player|
        if player.getId == id
          nick = player.getNickname
        end
      end
      nick
    end
    
    def sendMessage(playerId, message)
      if hasPlayer(playerId)
        @messages << (getNickById(playerId) +": "+ message)
      end
    end
    
    def getMessages(playerId)
      if hasPlayer(playerId)
        @messages
      else
        ""
      end
    end
    
    def addPlayer(user)
      @players << user
    end
    
    def getId
      @id
    end
    
    def printPlayers
      if @players.length == 0
        puts "room with id  #{@id}  has no players"
      else
        @players.each do |player|
          puts "room with id  #{@id}  has player  #{player.getNickname}"
        end
      end
    end
    
  end
  
  
  
  class GameController# < ApplicationController
    include Singleton
    
    @@rooms 
    @@players
    @@initialPlayerID
    
    def initialize
      @@rooms = Array.new
      @@players = Array.new
      @@initialPlayerID = 1000
    end
    
    def createPlayer(name, email, money = 50000)  #возвращает playerID
      u = Player.new(@@initialPlayerID, name, email, money)
      @@initialPlayerID = @@initialPlayerID + 1
      @@players << u
      return @@initialPlayerID-1
    end
    
    def self.printAllPlayers
      @@players.each do |player|
        puts "player id = #{player.getId}, nickname = #{player.getNickname}"
      end
    end
    
    def hello
      puts "Hello, I'm an instance of SuperClass and my ID is #{object_id}"
    end
    
    
    
    def self.validPlayerId(id)
      return true
      validId = false
      @@players.each do |player|
        if player.getId == id
          validId = true
        end
      end
      validId      
    end
    
    def self.validRoomId(id)
      return true
      validId = false
      @@rooms.each do |room|
        if room.getId == id
          validId = true
        end
      end
      validId
      
    end
    
    def self.findRoom(id)
      r = nil
      @@rooms.each do |room|
        if room.getId == id
          r = room
        end 
      end
      r
    end
    
    def self.sendMessage(playerId, roomId, message)
      if validPlayerId(playerId) and validRoomId(roomId)
        room = findRoom(roomId)
        room.sendMessage(playerId, message)
      end
    end
    
    def self.getMessages(playerId, roomId)
      if validPlayerId(playerId) and validRoomId(roomId)
        room = findRoom(roomId)
        room.getMessages(playerId)
      end
    end
    
    def self.addRoom(name, creatorId)
      
      if validPlayerId(creatorId) == true and not validRoomId(name)
        r = Room.new(name, creatorId)
        @@rooms << r
        return true
      else
        return false
      end
    end
    
    def joinRoom(userId, roomId)
      false
      if validPlayerId(userId) and validRoomId(roomId)
        r = nil
        @rooms.each do |room|
          if room.getId == roomId
            r = room
          end
        end
        u = nil
        @players.each do |player|
          if player.getId == userId
            u = player
          end 
        end
        if u == nil || r == nil
          puts "!!!!!!!!!!!!!!!!!!!!!!"
        end
        r.addPlayer(u)
        true
      end
      
    end
    
    def addPlayer(user)
      @players << user
    end
    
    def self.getRooms
    names = Array.new
    @@rooms.each do |room|
      names << room.getId
    end
      names #списком
    end
  end

  if __FILE__ == $0
    gc = GameController.instance
    id1 = gc.createPlayer("1st", "")
    id2 = gc.createPlayer("2nd", "")
    id3 = gc.createPlayer("3rd", "")
    id4 = gc.createPlayer("4th", "")
    gc.addRoom("roomOf1st", id1)
    gc.addRoom("roomOf3rd", id3)
    rooms = gc.getRooms
    gc.joinRoom(id1, rooms[0])
    gc.joinRoom(id2, rooms[0])
    gc.joinRoom(id3, rooms[1])
    gc.joinRoom(id4, rooms[1])
    gc.sendMessage(id1, rooms[0], "message1room1player1")
    gc.sendMessage(id2, rooms[0], "message1room1player2")
    gc.sendMessage(id3, rooms[1], "player3 speaks")
    puts "*************************"
    puts gc.getMessages(id2, rooms[0])
    puts "*************************"
    puts gc.getMessages(id4, rooms[1])
    puts "*************************"
    puts gc.getMessages(id1, rooms[1])
    puts gc.getMessages(id1, rooms[0])
    puts "*************************"
    puts gc.getRooms
    
  end 

end