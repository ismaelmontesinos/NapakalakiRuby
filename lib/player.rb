# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'prize'
require_relative 'bad_consequence'
require_relative 'treasure_kind'
require_relative 'treasure'
require_relative 'card_dealer'

module Napakalaki
class Player
  
  attr_reader :name,:level,:dead,:canISteal,:enemy,:visibleTreasures,:hiddenTreasures,:pendingBadConsequence, :MAXLEVEL
  @@MAXLEVEL=10
  
  def initialize(nm)
    @name=nm
    @level=1
    @dead=false
    @canISteal
#    @enemy=Player.new
#    @pendingBadConsequence=BadConsequence.new
    @visibleTreasures=Array.new 
    @hiddenTreasures=Array.new
    @enemy
  end
   
  
  def isDead
    return @dead
  end
  
  def self.getMAXLEVEL
    return @@MAXLEVEL
  end
   
  def combat(m)
    
       myLevel=self.getCombatLevel#1.1.1
       monsterLevel=m.getCombatLevel#1.1.2
       @combatResult=CombatResult
       if(myLevel>monsterLevel)
         self.applyPrize(m)#1.1.3
         if(@level>=@@MAXLEVEL)
           combatResult.WINGAME
         else
           combatResult.WIN
         end
       else
         self.applyBadConsequence(m)#1.1.4
         combatResult.LOSE
       end
       return combatResult
  end
   
  def makeTreasureVisible(t)
       canI=self.canMakeTreasureVisible(t)
       if(canI)
         @visibleTreasures<<t
         @hiddenTreasures.delete(t)
       end
  end
   
  def discardVisibleTreasure(t)
       @visibleTreasures.delete(t)#1.2.1
       if((@pendingBadConsequence!=null)&&(!@pendingBadConsequence.isEmpty))
         @pendingBadConsequence.substractVisibleTreasure#1.2.2
       end
       self.dieIfNoTreasures#1.2.3
  end
   
  def discardHiddenTreasure( t)
        @hiddenTreasures.delete(t)#1.2.1
        if((@pendingBadConsequence!=null)&&(!@pendingBadConsequence.isEmpty))
           @pendingBadConsequence.substractHiddenTreasure#1.2.2
        end
        self.dieIfNoTreasures#1.2.3
  end
   
  def validState
    res=false
    if(@pendingBadConsequence.isEmpty && @hiddenTreasures.length<4)
      res=true
    end
    return res
  end
   
  def initTreasures
       dealer=CardDealer.getInstance#1
       dice=Dice.getInstance#2
       bringToLife#3
       treasure=dealer.nextTreasure#4
       @hiddenTreasures<<treasure#5
       number = dice.nextNumber#6
       if(number>1)
         treasure=dealer.nextTreasure#7
         @hiddenTreasures<<treasure#8
       end
       if(number==6)
         treasure=dealer.nextTreasure#9
         @hiddenTreasure<<treasure#10
       end
  end
   
  def stealTreasure
       canI=self.canIsteal#1.1
       treasure=nil
       if(canI)
         canYou=@enemy.canYouGiveMeATreasure#1.2
         if(canYou)
           treasure=enemy.giveMeATreasure
           hiddenTreasures<<treasure
           self.haveStolen
         end
       end
  end
   
   
  def setEnemy(e)
    @enemy=e
  end
   
  def canISteal
    @canISteal
  end
   

   
  def discardAllTreasures
       @visibleTreasures.each do |treasure|#1.1
         t=treasure
         self.discardVisibleTreasure(t)#1.2
       end
       @hiddenTreasures.each do |treasure|#1.3
         t=treasure
         self.discardHiddenTreasure(t)#1.4
       end
  end
    
  private
  
  def bringToLife
    @dead=false
  end
   
  protected
  def  getCombatLevel
    lv=@level
    visibleTreasures.each {|t| lv+=t.bonus}
    hiddenTreasures.each {|t| lv+=t.bonus}

    return lv
  end
   
  def incrementLevels(i)
    @level+=i
  end
   
  def decrementLevels(i)
    @level-=i
  end
   
  def setPendingBadConsequence(b)
    @pendingBadConsequence=b 
  end
   
  def applyPrize(m)
       nLevels=m.getLevelsGained#1
       l=nLevels
       self.incrementLevels(l)#2
       nTreasures=m.getTreasuresGained#3
       if(nTreasures>0)
         dealer=CardDealer.getInstance#4
         nTreasures.each do |treasure|#5
           hiddenTreasures<<treasure#6
         end
       end
  end
  
  def applyBadConsequence(m)
    badConsequence=m.getBadConsequence#1
    nLevels=badConsequence.getLevels#2
    l=nLevels
    self.decrementLevels(l)#3
    v=visibleTreasures
    h=hiddenTreasures
    pendingBad = badConsequence.adjustToFitTreasureLists(v,h)#4
    b=pendingBad
    self.setPendingBadConsequence(b)#5
  end
   
  def canMakeTreasureVisible(t)
       
  end
    
  def howManyVisibleTreasures(tKind)
    i=0
    @visibleTreasures.each {|t| if t.type ==tKind then i=il+1   end}
    return i
  end
   
  def dieIfNotTreasures
    if(@visibleTreasures.length==0&&@hiddenTreasures.length==0)
      dead=true
    end
    return dead
  end
  
  def giveMeATreasure
    @t=visibleTreasures.get(rand(visibleTreasures.size()))
    return t
  end
 
  def canYouGiveMeATreasure
    res=false
    if(@hiddenTreasures.length>0 && @visibleTreasures.length>0)
      res=true
    end
    res
  end
   
  def haveStolen
    @canISteal=false
  end
  
  protected 
  def getOponentLevel(m)
    return m.getCombatLevel
    
  end
  
  protected 
  def shouldConvert
    dice=Dice.getInstance
    convert=false
    if(dice.nextNumber==1)
      convert=true
    end
    return convert
  end
  def to_s
    "Nombre: " + @name + "\nNivel: " + @level + "\nNivel de Combate: " + getCombatLevel + "\n"
  end
end
end