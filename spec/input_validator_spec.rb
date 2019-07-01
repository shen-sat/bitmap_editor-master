require_relative '../lib/input_validator'

describe 'InputValidator' do
	#TODO spaces before and after trailing spaces - use chomp
	#TODO lowercase input?

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

		it 'should not accept lowercase letters' do
			expect(input_validator.validate_character('i')).to eq('Error')
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
			invalid_letters = ('A'..'Z').to_a - ['I', 'C', 'L', 'V', 'H', 'S']
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

		it 'should only accept a single C' do
			input_validator = InputValidator.new
			expect(input_validator.validate_line('C A')).to eq('Error')
			expect(input_validator.validate_line('C 1')).to eq('Error')
		end

		it 'should only accept two numbers and a letter following an L' do
			input_validator = InputValidator.new
			expect(input_validator.validate_line('L A')).to eq('Error')
			expect(input_validator.validate_line('L 1')).to eq('Error')
			expect(input_validator.validate_line('L 1 A')).to eq('Error')
			expect(input_validator.validate_line('L 1 3')).to eq('Error')
			expect(input_validator.validate_line('L 1 3 A C')).to eq('Error')
			expect(input_validator.validate_line('L 1 3 A 5')).to eq('Error')
		end

		it 'should only accept three numbers and a letter following a V' do
			input_validator = InputValidator.new
			expect(input_validator.validate_line('V A')).to eq('Error')
			expect(input_validator.validate_line('V 2')).to eq('Error')
			expect(input_validator.validate_line('V 2 A')).to eq('Error')
			expect(input_validator.validate_line('V 2 3')).to eq('Error')
			expect(input_validator.validate_line('V 2 3 A')).to eq('Error')
			expect(input_validator.validate_line('V 2 3 6 5')).to eq('Error')
			expect(input_validator.validate_line('V 2 3 6 W A')).to eq('Error')
			expect(input_validator.validate_line('V 2 3 6 W 9')).to eq('Error')
		end

		it 'should only accept three numbers and a letter following an H' do
			input_validator = InputValidator.new
			expect(input_validator.validate_line('H A')).to eq('Error')
			expect(input_validator.validate_line('H 2')).to eq('Error')
			expect(input_validator.validate_line('H 2 A')).to eq('Error')
			expect(input_validator.validate_line('H 2 3')).to eq('Error')
			expect(input_validator.validate_line('H 2 3 A')).to eq('Error')
			expect(input_validator.validate_line('H 2 3 6 5')).to eq('Error')
			expect(input_validator.validate_line('H 2 3 6 W A')).to eq('Error')
			expect(input_validator.validate_line('H 2 3 6 W 9')).to eq('Error')
		end

		it 'should only accept a single S' do
			input_validator = InputValidator.new
			expect(input_validator.validate_line('S A')).to eq('Error')
			expect(input_validator.validate_line('S 1')).to eq('Error')
		end

	end

end