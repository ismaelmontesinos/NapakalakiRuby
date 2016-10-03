# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'treasure_kind'

module Napakalaki
class Treasure
  attr_reader :name,:bonus,:type
  
  def initialize(n,bn,t)
    @name=n
    @bonus=bn
    @type=t
  end
  
end
end