require "servicon/version"
require "servicon/bin"
require "paint"
require "digest"

module Servicon

  class Icon
    attr_accessor :fingerprint
    
    def initialize(fingerprint, color = true, ascii = false)
      @color = color
      @ascii = ascii
      @fingerprint = fingerprint
      @uuid = self.uuid
    end

    def uuid
      uuid = Digest::SHA1.hexdigest(@fingerprint).unpack('H*')[0].to_i(16)
    end

    def matrix
      line = Array.new
      identicon = Array.new

      0.upto(63) do |i|
        line << @uuid[i]
        if line.count == 8
          identicon << line + line.reverse
          line = Array.new
        end
      end

      return identicon
    end

    def rgb
      color = Hash.new
      color[:red] = (@uuid & 0xff)
      color[:blue] = ((@uuid >> 8) & 0xff)
      color[:green] = ((@uuid >> 16) & 0xff)
      return color
    end

    def ascii
      character_group = [['#', ' '],
                         ['-', '+'],
                         ['_', '-'],
                         ['[', ']'],
                         ['\'', '"'],
                         ['/', '\\'],]


      group = character_group[(@uuid % character_group.length)]

      return group
    end
    
    def display
      draw_matrix(matrix)
    end

    def draw_matrix(matrix)
      my_row = Array.new
      
      matrix.each do |row|
         my_row << draw_row(row)
      end
      
      return my_row.join
    end
    
    def draw_row(matrix_row)
      line = Array.new

      matrix_row.each do |character|
        line << draw_char(character)
      end
        
      return line.join + "\n"
    end

    def draw_char(character)
      rgb = [self.rgb[:red], self.rgb[:green], self.rgb[:blue]]
      rgb.collect! { |n| n / 2 } if character == 1
 
      @ascii ? char = self.ascii[character] : char = ' '
      @ascii ? background = nil : background = rgb
      (@ascii and @color) ? foreground = rgb : foreground = nil
 
      Paint[char, foreground, background]
    end
  end

  class Servicon::NoCodeError < StandardError; end    

end
