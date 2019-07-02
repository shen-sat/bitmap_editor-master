require_relative '../lib/processor'
#TODO what happens with numbers in L, V and H inputs which start with a higher number and then a lower number ie draw line backwards

describe 'Processor' do

	it 'should return an array within an array of one "O" for input "I11"' do
		processor = Processor.new
		processor.process('I11')
		expect(processor.table).to eq([['O']])		
	end

	it 'should return two arrays within an array, each containing two "O" for input "I22"' do
		processor = Processor.new
		processor.process('I22')
		expect(processor.table).to eq([['O','O'], ['O','O']])		
	end


	it 'should return six arrays within an array, each containing five "O" for input "I56"' do
		processor = Processor.new
		processor.process('I56')
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

	it 'should convert the first element in the first array to "Z" for input L11Z' do
		processor = Processor.new
		processor.table = [['A', 'B'], ['C', 'D']]
		processor.process('L11Z')
		expect(processor.table).to eq([['Z', 'B'], ['C', 'D']])
	end

	it 'should convert the last element in the last array to "Z" for input L22Z' do
		processor = Processor.new
		processor.table = [['A', 'B'], ['C', 'D']]
		processor.process('L22Z')
		expect(processor.table).to eq([['A', 'B'], ['C', 'Z']])
	end


	it 'should convert the last element in the first array to "Z" for input L12Z' do
		processor = Processor.new
		processor.table = [['A', 'B'], ['C', 'D']]
		processor.process('L21Z')
		expect(processor.table).to eq([['A', 'Z'], ['C', 'D']])
	end

	it 'should convert the first column to "Z" for the input V113Z' do
		processor = Processor.new
		processor.table = [['A', 'B', 'C'], ['D', 'E', 'F'], ['G', 'H', 'I']]
		processor.process('V113Z')
		expect(processor.table).to eq([['Z', 'B', 'C'], ['Z', 'E', 'F'], ['Z', 'H', 'I']])
	end

	it 'should convert two-thirds of the last column to "Z" for the input V312Z' do
		processor = Processor.new
		processor.table = [['A', 'B', 'C'], ['D', 'E', 'F'], ['G', 'H', 'I']]
		processor.process('V312Z')
		expect(processor.table).to eq([['A', 'B', 'Z'], ['D', 'E', 'Z'], ['G', 'H', 'I']])
	end


end