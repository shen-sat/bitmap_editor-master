require_relative '../lib/input_validator'

describe 'InputValidator' do

	context 'when validating individual characters,' do
		
		it 'should not accept symbols' do
			#TODO how to test a range of symbols?
			input_validator = InputValidator.new
			expect(input_validator.validate_character('.')).to eq("Error")
			expect(input_validator.validate_character(',')).to eq("Error")
		end

		it 'should not accept letters that are not I, N, M, C, L, V, H, S' do
			input_validator = InputValidator.new
			expect(input_validator.validate_character('A')).to eq("Error")
		end

		it 'should not accept 0' do
			input_validator = InputValidator.new
			expect(input_validator.validate_character('0')).to eq("Error")
		end
	end
	

end