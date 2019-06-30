require_relative '../lib/input_validator'

describe 'InputValidator' do

	context 'when validating individual characters,' do
		
		input_validator = InputValidator.new
		
		it 'should not accept symbols' do
			#TODO how to test a range of symbols?
			symbols = ['.', ',']
			symbols.each {|symbol| expect(input_validator.validate_character(symbol)).to eq('Error') }
		end

		it 'should not accept letters that are not I, N, M, C, L, V, H, S' do
			incorrect_letters = ('A'..'Z').to_a - ['I', 'N', 'M', 'C', 'L', 'V', 'H', 'S']
			incorrect_letters.each {|letter| expect(input_validator.validate_character(letter)).to eq('Error') }
		end

		it 'should not accept 0' do
			expect(input_validator.validate_character('0')).to eq('Error')
		end
	end

end