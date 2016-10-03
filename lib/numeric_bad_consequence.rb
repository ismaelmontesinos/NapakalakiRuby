# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.


module Napakalaki
  class NumericBadConsequence < BadConsequence
    attr_reader :nVisibleTreasures, :nHiddenTreasures
    def initialize(t,someLevels,someVisibleTreasures,someHiddenTreasures)
      super(t,someLevels)
      @nVisibleTreasures=someVisibleTreasures
      @nHiddenTreasures=someHiddenTreasures
    end
    
    def isEmpty 
      empty=false
      if(nVisibleTreasures==0 && nHiddenTreasures==0)
        empty=true
      end
      return empty
    end
    
    def subtractVisibleTreasures(t)
      if(@nVisibleTreasures>0)
        @nVisibleTreasures -=1
      end
    end
    
    def subtractHiddenTreasures(t)
      if(@nHiddenTreasures>0)
        @nHiddenTreasures -=1
      end
    end
    
    def
      NumericBadConsequence.newLevelNumberOfTreasures(aText,someLevels,someNumericVisibleTreasures,someNumericHiddenTreasures)
         new(aText,someLevels,someNumericVisibleTreasures, someNumericHiddenTreasures)
    end
    def to_s
      super.to_s + "Numero de Tesoros Visibles: " + @nVisibleTreasures+ "\n Numero de Tesoros Ocultos: " + @nHiddenTreasures+"\n"
    end
  end
end
