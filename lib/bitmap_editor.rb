require_relative 'input_validator'
require_relative 'processor'

class BitmapEditor
  attr_reader :input_validator, :processor

  def initialize
    @input_validator = InputValidator.new
    @processor = Processor.new
  end

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    File.open(file).each do |line|
      line = line.chomp
      input_validator.validate_line(line)
      case line
      when 'S'
          processor.table.each do |row|
            row.each do |pixel|
              print pixel
            end
            puts ""
          end
      else
          processor.process(line)
      end
    end
  end
end
