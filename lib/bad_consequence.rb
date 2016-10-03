# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "treasure_kind.rb"
require_relative "treasure.rb"

module Napakalaki
  class BadConsequence
    
    @@MAXTREASURES=10
    def 
      initialize( atext,  someLevels)
          @text=atext
          @levels=someLevels

    end


    def
       getText
          @text
    end

    def
      getLevels
        @levels
    end

    def
       getnVisibleTreasures
        @nVisibleTreasures
    end
    def
      getnHiddenTreasures
          @nHiddenTreasures
    end

    def
    getDeath
         @death
    end
    
    private_class_method:new


      def to_s
        "Bad consequence: #{@text} \nPierdes: #{@levels} niveles."
      end

      def isEmpty
        empty=false
        if(@levels==0&&@death==false&&@nHiddenTreasures==0&&nVisibleTreasures==0
            @nSpecificHiddenTreasures.length==0&&@nSpecificVisibleTreasures.length==0)
          empty=true
        end
        return empty
      end

      def subtractVisibleTreasure(t)
        @nSpecificVisibleTreasures.delete(t.getType())
        if (@nSpecificVisibleTreasures.size()!=0)
          @nVisibleTreasures=nVisibleTreasures-1
        end
      end

      def subtractHiddenTreasure(t)
        nSpecificVisibleTreasures.delete(t.getType())
        if(nSpecificHiddenTreasrures.size()!=0)
          nHiddenTreasures=nHiddenTreasures-1
        end
      end

      def adjustToFitTreasureLists(v,h)

      end

  end
end