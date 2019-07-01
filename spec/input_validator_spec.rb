require_relative '../lib/input_validator'

describe 'InputValidator' do

	context 'when validating individual characters,' do
		
		input_validator = InputValidator.new
		
		it 'should not accept symbols' do
			#TODO how to test a range of symbols?
			symbols = ['.', ',']
			symbols.each {|symbol| expect(input_validator.validate_character(symbol)).to eq('Error') }
		end

		it 'should not accept 0' do
			expect(input_validator.validate_character('0')).to eq('Error')
		end
	end

	context 'when validating individual lines of input,' do

		it 'should not accept no spaces' do
			input_validator = InputValidator.new
			expect(input_validator.validate_line('I56')).to eq('Error')
		end

		it 'should not accept more than one consecutive space' do
			input_validator = InputValidator.new
			expect(input_validator.validate_line('I 5  6')).to eq('Error')
		end

		it 'should only accept I, C, L, V, S as the first character' do
			invalid_letters = ('A'..'Z').to_a - ['I', 'C', 'L', 'V', 'S']
			invalid_numbers = ('1'..'9').to_a
			invalid_first_characters = invalid_letters + invalid_numbers
			input_validator = InputValidator.new
			invalid_first_characters.each {|character| expect(input_validator.validate_line(character)).to eq('Error')}
		end

		it 'should only accept two numbers following an I' do
			input_validator = InputValidator.new
			expect(input_validator.validate_line('I A')).to eq('Error')
			expect(input_validator.validate_line('I A B')).to eq('Error')
			expect(input_validator.validate_line('I 5')).to eq('Error')
			expect(input_validator.validate_line('I 5 6 6')).to eq('Error')

		end

	end

end