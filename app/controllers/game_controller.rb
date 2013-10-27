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
  
  @id
  @players
  @name
  @creatorId
  @messages
  
  def initialize(id, name, creatorId)
    @id = id
    @players = Array.new
    @messages = Array.new
    @name = name
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
  
  def getName
    @name
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



class GameController < ApplicationController
  include Singleton
  
  @id #roomID
  @rooms 
  @players
  @initialPlayerID
  
  def initialize
    @rooms = Array.new
    @players = Array.new
    @initialPlayerID = 1000
    @id = 0
  end
  
  def createPlayer(name, email, money = 50000)  #возвращает playerID
    u = Player.new(@initialPlayerID, name, email, money)
    @initialPlayerID = @initialPlayerID + 1
    @players << u
    @initialPlayerID-1
  end
  
  def printAllPlayers
    @players.each do |player|
      puts "player id = #{player.getId}, nickname = #{player.getNickname}"
    end
  end
  
  def hello
    puts "Hello, I'm an instance of SuperClass and my ID is #{object_id}"
  end
  
  
  
  def validPlayerId(id)
    validId = false
    @players.each do |player|
      if player.getId == id
        validId = true
      end
    end
    validId
    
  end
  
  def validRoomId(id)
    validId = false
    @rooms.each do |room|
      if room.getId == id
        validId = true
      end
    end
    validId
    
  end
  
  def findRoom(id)
    r = nil
    @rooms.each do |room|
      if room.getId == id
        r = room
      end 
    end
    r
  end
  
  def sendMessage(playerId, roomId, message)
    if validPlayerId(playerId) and validRoomId(roomId)
      room = findRoom(roomId)
      room.sendMessage(playerId, message)
    end
  end
  
  def getMessages(playerId, roomId)
    if validPlayerId(playerId) and validRoomId(roomId)
      room = findRoom(roomId)
      room.getMessages(playerId)
    end
  end
  
  def addRoom(name, creatorId)
    
    if validPlayerId(creatorId) == true
      r = Room.new(@id, name, creatorId)
      @rooms << r
      @id = @id + 1
      true
    else
      false
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
  
  def getRooms
    @rooms
  end
end