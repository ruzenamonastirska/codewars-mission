class Trimmer
  TRIMMING_SEQUENCE = %i[top! rgt! bot! lft!].freeze
  private_constant :TRIMMING_SEQUENCE
  attr_reader :trimmings
  
  def self.trim_down(array)
    return [] unless array.first&.first
    
    self.new(array).trimmings
  end
  
  def initialize(array)
    @array = array.dup
    @trimmings = []
    do_magic!
  end
  
  private
  
  def do_magic!
    while @array.first&.first
      @trimmings.append(*trim_next_side!)
    end
  end

  def trim_next_side!
    @trim_rotation ||= TRIMMING_SEQUENCE.dup
    send(@trim_rotation.rotate!.last)
  end

  def top!; @array.shift; end
  def rgt!; @array.map(&:pop); end
  def bot!; @array.pop.reverse; end
  def lft!; @array.map(&:shift).reverse; end
end

def snail(a)
  Trimmer.trim_down(a)
end