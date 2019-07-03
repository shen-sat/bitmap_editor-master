require_relative '../lib/bitmap_editor'

describe 'BitmapEditor' do

	it 'should initialise with a InputValidator and Processor' do
		bitmap_editor = BitmapEditor.new
		bitmap_editor.input_validator != nil
		bitmap_editor.processor != nil
	end

	it 'should retrun test output for test input' do
		Dir.chdir(File.dirname(__FILE__))
		file = File.open('../examples/test_input.txt')
		bitmap_editor = BitmapEditor.new
		expect { bitmap_editor.run(file) }.to output("OOOOO\nOOZZZ\nAWOOO\nOWOOO\nOWOOO\nOWOOO\n").to_stdout
	end
end