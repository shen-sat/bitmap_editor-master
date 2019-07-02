require_relative '../lib/processor'

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

	it 'should clear a single-pixel coloured table to white for input "C"' do
		processor = Processor.new
		processor.table = [['A']]
		processor.process('C')
		expect(processor.table).to eq([['O']])
	end

	it 'should clear a multi-pixel coloured table to white for input "C"' do
		processor = Processor.new
		processor.table = [['A', 'B'], ['C', 'D'], ['E', 'F']]
		processor.process('C')
		expect(processor.table).to eq([['O', 'O'], ['O', 'O'], ['O', 'O']])
	end

end