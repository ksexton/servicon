require 'optparse'

class Servicon::Bin

  def initialize(args)
    @args = args
  end

  def run
    help = <<-EOHELP
    Servicon

    Basic Command Line Usage:
      servicon [OPTIONS] [FINGERPRINT]

            FINGERPRINT                  Unique ID to generate identicon

    Options:
    EOHELP

    opts = OptionParser.new do |opts|
      opts.banner = help

      opts.on("--version", "Display current version.") do
        puts "servicon " + Servicon::VERSION
        return 0
      end
    end

    begin
      opts.parse!(@args)
    rescue OptionParser::InvalidOption
      puts "servicon: #{$!.message}"
      puts "servicon: try 'servicon --help' for more information"
      return 1
    end

    if @args[0].nil?
      puts "servicon: no fingerprint specified"
      puts "servicon: try 'servicon --help' for more information"
      return 1
    end

    begin
      return_val = 0
      i = Servicon::Servicon.new(@args[0])
      puts i.create
      return return_val
    rescue Servicon::Servicon::NoCodeError
      puts "servicon: no file specified or specified file does not exist"
      puts "servicon: try 'servicon --help' for more information"
      return 1
    end
  end
end
