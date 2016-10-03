# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'bad_consequence'

module Napakalaki
  class SpecificBadConsequence < BadConsequence
    def initialize(t, someLevels, someSpecificVisibleTreasures, someSpecificHiddenTreasures)
      super(t,someLevels)
      @specificVisibleTreasures=someSpecificVisibleTreasures
      @specificHiddenTreasures=someSpecificHiddenTreasures
    end
    
    def subtractVisibleTreasures(t)
      if(!@specificVisibleTreasures.empty?)
        @specificVisibleTreasures.delete(t.type)
      end
    end
    def subtractHiddenTreasres(t)
      if(!@specificHiddenTreasures.empty?)
        @specificHiddenTreasures.delete(t.type)
      end
    end
    def isEmpty
      empty=false
      if(@specificVisibleTreasures.empty? && @specificHiddenTreasures.emtpy?)
        emtpy=true
      end
      return emtpy
    end
    
    def to_s
      super.to_s +"Mal rollo Visible específico: "+ @specificVisibleTreasures + "\nMal rollo Oculto específico" + @specificHiddenTreasures + "\n"
    end
    
  end
end
