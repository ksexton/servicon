require "servicon/version"
require 'paint'
require 'digest'

module Servicon

  class Servicon
    attr_accessor :key, :fingerprint, :identifier
    
    def initialize(fingerprint)
      @fingerprint = fingerprint
      @identifier = self.identifier
    end

    def identifier
      identifier = Digest::MD5.hexdigest(@fingerprint).unpack('H*')[0].to_i(16)
    end

    def matrix
      line = Array.new
      identicon = Array.new

      63.downto(0) do |i|
        line << @identifier[i]
        if (i % 8 == 0)
          line << @identifier[i]
          identicon << line + line.reverse
          line = Array.new
        end
      end
      return identicon
    end

    def rgb
      color = Hash.new
      color[:red] = (@identifier & 0xff)
      color[:blue] = ((@identifier >> 8) & 0xff)
      color[:green] = ((@identifier >> 16) & 0xff)
      return color
    end
    
    def color(matrix_line)
      rgb = self.rgb

      red = rgb[:red]
      green = rgb[:green]
      blue = rgb[:blue]

      line = Array.new
      matrix_line.each do |character|
        if character == 0
          line << Paint[' ', nil, [red, green, blue]]
        elsif character == 1
          line << Paint[' ', nil, [red / 2, green / 2, blue / 2]]
        end
      end
      return line.join
    end
    

    def create
      matrix = self.matrix

      icon = String.new
      matrix.each do |line|
        icon = icon + color(line) + "\n"
      end
      return icon
    end
    
  end


end
