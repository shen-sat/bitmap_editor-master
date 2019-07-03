require_relative '../lib/processor'
#TODO lines are out-of-bounds
#TODO what happens if I input is not first? If @table is empty, store commands, then run them at the end
#TODO warning if 'C' command has inout after it
#TODO handle multiple tables ie multiple I inputs - new table for each?
#TODO test for 'S' input (another spec)

describe 'Processor' do

	it 'should return an array within an array of one "O" for input "I 1 1"' do
		processor = Processor.new
		processor.process('I 1 1')
		expect(processor.table).to eq([['O']])		
	end

	it 'should return two arrays within an array, each containing two "O" for input "I 2 2"' do
		processor = Processor.new
		processor.process('I 2 2')
		expect(processor.table).to eq([['O','O'], ['O','O']])		
	end


	it 'should return six arrays within an array, each containing five "O" for input "I 5 6"' do
		processor = Processor.new
		processor.process('I 5 6')
		expect(processor.table).to eq([['O','O','O','O','O'], ['O','O','O','O','O'], ['O','O','O','O','O'], ['O','O','O','O','O'], ['O','O','O','O','O'], ['O','O','O','O','O']])		
	end

	it 'should clear a single-pixel coloured table to all "O" for input "C"' do
		processor = Processor.new
		processor.table = [['A']]
		processor.process('C')
		expect(processor.table).to eq([['O']])
	end

	it 'should clear a multi-pixel coloured table to to all "O" for input "C"' do
		processor = Processor.new
		processor.table = [['A', 'B'], ['C', 'D']]
		processor.process('C')
		expect(processor.table).to eq([['O', 'O'], ['O', 'O']])
	end

	it 'should convert the first element in the first array to "Z" for input L 1 1 Z' do
		processor = Processor.new
		processor.table = [['A', 'B'], ['C', 'D']]
		processor.process('L 1 1 Z')
		expect(processor.table).to eq([['Z', 'B'], ['C', 'D']])
	end

	it 'should convert the last element in the last array to "Z" for input L 2 2 Z' do
		processor = Processor.new
		processor.table = [['A', 'B'], ['C', 'D']]
		processor.process('L 2 2 Z')
		expect(processor.table).to eq([['A', 'B'], ['C', 'Z']])
	end


	it 'should convert the last element in the first array to "Z" for input L 2 1 Z' do
		processor = Processor.new
		processor.table = [['A', 'B'], ['C', 'D']]
		processor.process('L 2 1 Z')
		expect(processor.table).to eq([['A', 'Z'], ['C', 'D']])
	end

	it 'should convert the first column to "Z" for the input V 1 1 3 Z' do
		processor = Processor.new
		processor.table = [['A', 'B', 'C'], ['D', 'E', 'F'], ['G', 'H', 'I']]
		processor.process('V 1 1 3 Z')
		expect(processor.table).to eq([['Z', 'B', 'C'], ['Z', 'E', 'F'], ['Z', 'H', 'I']])
	end

	it 'should convert first two-thirds of the last column to "Z" for the input V 3 1 2 Z' do
		processor = Processor.new
		processor.table = [['A', 'B', 'C'], ['D', 'E', 'F'], ['G', 'H', 'I']]
		processor.process('V 3 1 2 Z')
		expect(processor.table).to eq([['A', 'B', 'Z'], ['D', 'E', 'Z'], ['G', 'H', 'I']])
	end

	it 'should convert the first row to "Z" for the input H 1 3 1 Z' do
		processor = Processor.new
		processor.table = [['A', 'B', 'C'], ['D', 'E', 'F'], ['G', 'H', 'I']]
		processor.process('H 1 3 1 Z')
		expect(processor.table).to eq([['Z', 'Z', 'Z'], ['D', 'E', 'F'], ['G', 'H', 'I']])
	end

	it 'should convert last two-thirds of the middle row to "Z" for the input H 2 3 2 Z' do
		processor = Processor.new
		processor.table = [['A', 'B', 'C'], ['D', 'E', 'F'], ['G', 'H', 'I']]
		processor.process('H 2 3 2 Z')
		expect(processor.table).to eq([['A', 'B', 'C'], ['D', 'Z', 'Z'], ['G', 'H', 'I']])
	end

	it 'should handle multiple lines of input' do
		processor = Processor.new
		processor.process('I 4 4')
		processor.process('L 2 3 X')
		processor.process('V 4 2 4 Y')
		processor.process('H 1 3 2 Z')
		expect(processor.table).to eq([['O','O','O','O'],['Z','Z','Z','Y'],['O','X','O','Y'],['O','O','O','Y']])
	end

	it 'should handle drawing vertical lines from bottom to top' do
		processor = Processor.new
		processor.table = [['O','O','O'], ['O','O','O'], ['O','O','O']]
		processor.process('V 3 3 2 Z')
		expect(processor.table).to eq([['O','O','O'],['O','O','Z'],['O','O','Z']])
	end

	it 'should handle drawing horizontal lines from right to left' do
		processor = Processor.new
		processor.table = [['O','O','O'], ['O','O','O'], ['O','O','O']]
		processor.process('H 3 1 2 Z')
		expect(processor.table).to eq([['O','O','O'],['Z','Z','Z'],['O','O','O']])
	end

	it 'should raise an error if "L" input is out of bounds' do
		processor = Processor.new
		processor.table = [['O','O'], ['O','O']]
		expect(processor.process('L 3 2 X')).to eq('Error')
		expect(processor.process('L 2 3 X')).to eq('Error')
	end

	it 'should raise an error if "V" input is out of bounds' do
		processor = Processor.new
		processor.table = [['O','O'], ['O','O']]
		expect(processor.process('V 3 1 2 X')).to eq('Error')
		expect(processor.process('V 1 3 2 X')).to eq('Error')
		expect(processor.process('V 1 1 3 X')).to eq('Error')
	end

	it 'should raise an error if "H" input is out of bounds' do
		processor = Processor.new
		processor.table = [['O','O'], ['O','O']]
		expect(processor.process('H 3 1 2 X')).to eq('Error')
		expect(processor.process('H 1 3 2 X')).to eq('Error')
		expect(processor.process('H 1 2 3 X')).to eq('Error')
	end



end