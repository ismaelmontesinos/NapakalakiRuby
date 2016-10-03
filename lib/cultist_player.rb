# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module Napakalaki
class Cultist_player < Player
    @@totalCultistPlayers
  def initialize (c)
    super(nm)
    @myCultistCard=c
  end
  protected def getCombatLevel
    nivel*=1.02
    nivel+=@myCultistCard.gainedLevels*@@totalCultistPlayers
  end
  protected def getOponentLevel(m)
    return m.getCombatLevelAgainstCultistPlayer
  end
  protected def shouldConvert
    return false
  end
  private def giveMeATreasure
    @visibleTreasures.shuffle
    return @visibleTreasures[0]
  end
  private def canYouGiveMeATreasure
    return(!super.enemy.visibleTreasures.isempty?)
  end
  def getCultistPlayer
    return @myCultistCard
  end
end
end
