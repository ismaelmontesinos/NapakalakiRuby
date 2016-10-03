# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.



module Napakalaki
class Prize
   
  def initialize(treasures,levels)
    @treasures=treasures
    @level=levels
  end
 
  def
    getTreasures
       @treasures
  end
  
  def
    getLevel
      @level
  end
  
  def
    to_s
    "Tesoros ganados: #{@treasures} \nNivel ganados: #{@level}"
  end
end
end
