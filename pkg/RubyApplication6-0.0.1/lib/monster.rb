# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'prize'
require_relative 'bad_consequence'
require_relative 'treasure_kind'
require_relative 'treasure'
module Napakalaki
  class Monster
    attr_reader :name,:bc,:price,:combatLevel,:levelChangeAgainstCultistPlayer
    def
      initialize( nm,  lv,prc,  badconseq,ic)
          @name=nm;
          @combatLevel=lv;
          @bc=badconseq;
          @price=prc;
          @levelChangeAgainstCultistPlayer=ic
    end

    def
      to_s
      "\n\tNombre: #{@name}\n\tNivel de combate: #{@combatLevel}\n\tBad Consequence: #{@bc.to_s}\n\tPrize: #{@price.to_s}"
    end

    def getLevelsGained
      return self.price.getLevel
    end

    def getTreasuresGained
      return self.price.getTreasures
    end
  end
end
