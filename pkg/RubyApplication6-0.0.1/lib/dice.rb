# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'singleton'
module Napakalaki
class Dice
  include Singleton
  
  def initialize
    
  end
  
  def getInstance
    return self.instance
  end
#  def self.nextNumber
#    return 1+rand(6)
#  end
end
end
