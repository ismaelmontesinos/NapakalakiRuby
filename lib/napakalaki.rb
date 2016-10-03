# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'singleton'

require_relative 'EjemploMain'

require_relative 'prize'
require_relative 'bad_consequence'
require_relative 'monster'
require_relative 'treasure_kind'
require_relative 'player'
require_relative 'treasure'
require_relative 'card_dealer'
require_relative 'combat_result'
require_relative 'dice'

module Napakalaki

class Napakalaki
  include Singleton
  
  attr_accessor:currentPlayer,:players,:dealer,:currentMonster
  
#  def initialize(cp,p,d,cm)  # el constructor sobra porque solo tiene una instancia. Las variables se inicializan en métodos privados que hemos añadido
#    @currentPlayer=cp
#    @players=p
#    @dealer=d
#    @currentMonster=cm
#  end
  
#  def getInstance     # debe ser un método de clase para que devuelva una instancia, de todas formas, sobra porque has puesto include Singleton
#    return Napakalaki.instance
#  end
  
  def nextTurnAllowed
    if (@currentPlayer == nil)
      return true
    else
      return @currentPlayer.validState
    end
  end
  
  private
  def initPlayers(names)
    @nombre
    @players=Array.new
    names.each {|s|   # cuando se usan variables hay que poner {  o do
      players << Player.new(s)}
    i=rand(@players.size)
    @currentPlayer=@players.at(i)   #lo añado para que esté inicializado el currentPlayer que vas a necesitar.
  end
  
  private 
  def nextPlayer
    
    if (@currentPlayer == nil) 
    then
      @currentPlayer=@players[rand(@players.size)]
    else

      if players.index(@currentPlayer) == @players.size
      then
      
        next_index = 0

      else
        
      next_index = @players.index(@currentPlayer) + 1
      
      end
    end
    
    @currenPlayer = @players.at(next_index)

    return @currentPlayer
  end
    
  private 
  def setEnemies
    i=0
  #   enemigo=Player.new  # no se puede crear un Objeto player sin inicializar
    begin
      i=rand(@players.size)
    end while (@players.at(i)==@currentPlayer)
    # enemigo.setEnemy(players.at(i))  # El enemigo se añade al currentPlayer, debe ser como pongo la isguietne línea
    
    @currentPlayer.setEnemy(@players.at(i))  #fíjate que antes se te había olvidado la @, debes tener cuidado.
  end
  
  public  #lo añado porque todos los siguientes son públicos
  
  def developCombat
        m=currentMonster
        currentPlayer.combat(m)#1.1
  end
    
  def discardVisibleTreasures( treasures)
        treasures.each do |t|#1.1
          currentPlayer.discardVisibleTreasure(t)#1.2
          dealer.giveTreasureBack(t)
        end
  end
    
  def discardHiddenTreasures(treasures)
       treasures.each do |t|#1.1
          t=treasures
          currentPlayer.discardHiddenTreasure(t)#1.2
          dealer.giveTreasureBack(t)
        end
  end
    
  def makeTreasuresVisible(t)
        treasures.each do |t|#1.1
          @currentPlayer.makeTreasureVisible(t)#1.2
        end
  end
    
  def initGame(names)
        initPlayers(names)#1.1   # los métodos privados en Ruby se llaman sin poner self. delante, lo quito de este y del siguiente
        setEnemies#1.2
        @dealer= CardDealer.instance
        @dealer.initCards
        self.nextTurn#1.4
  end
    
  def getCurrentPlayer
    return @currentPlayer
  end
    
  def getCurrentMonster
    return @currentMonster
  end
    
  def nextTurn
        stateOK = self.nextTurnAllowed#1.1
        stateOK = currentPlayer.validState#1.1.1
        if(stateOK)
          @currentMonster=dealer.nextMonster#1.2
          @currentPlayer=self.nextPlayer#1.3
          dead=currentPlayer.isDead#1.4
          if(dead)
            @currentPlayer.initTreasures#1.5
          end
        end
        return stateOK#1.6
  end
    
  def endOfGame(result)
    cR=CombatResult.new
    termina=false
    if(result==cR.WINGAME)
    termina=true
    end
    return termina
  end
end
end
