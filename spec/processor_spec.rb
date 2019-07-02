require_relative '../lib/processor'

describe 'Processor' do

	it 'should return an array within an array of one "O" for input "I11"' do
		processor = Processor.new
		processor.process('I11')
		expect(processor.table).to eq([['O']])		
	end

end