# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.


require_relative 'player'

module Napakalaki
  class DeathBadConsequence < NumericBadConsequence
    def initialize(t)
      @death=true
      super(t,Player.getMAXLEVEL,@@MAXTREASURES,@@MAXTREASURES) 
    end
    
    
    def
      DeathBadConsequence.newDeath(aText)
       new(aText)
    end
    
    def to_s
      super.to_s + "Muere: #{@death}\n"
    end
  end
end