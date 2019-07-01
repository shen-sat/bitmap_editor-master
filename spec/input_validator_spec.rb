require_relative '../lib/input_validator'

describe 'InputValidator' do

	context 'when validating individual lines of input,' do

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

		it 'should not accept symbols' do
			input_validator = InputValidator.new
			lines_with_symbols = ['I . 6', 'C ?', 'L 1 , C', 'V 2 3 - W', 'H 3 5 2 +', '! S']
			lines_with_symbols.each {|line| expect(input_validator.validate_line(line)).to eq('Error')}
		end

		it 'should not accept lowercase letters' do
			input_validator = InputValidator.new
			lines_with_lowercase_letters = ['i 5 6', 'c', 'l 1 3 C', 'v 2 3 6 W', 'H 3 5 2 z', 's']
			lines_with_lowercase_letters.each {|line| expect(input_validator.validate_line(line)).to eq('Error')}
		end

		it 'should not accept double spaces' do
			input_validator = InputValidator.new
			lines_with_lowercase_letters = ['I  5 6', 'C  ', 'L 1  3 C', 'V 2 3  6 W', 'H 3 5 2  Z', '  S']
			lines_with_lowercase_letters.each {|line| expect(input_validator.validate_line(line)).to eq('Error')}
		end

		it 'should only accept I, C, L, V, S as the first character' do
			invalid_letters = ('A'..'Z').to_a - ['I', 'C', 'L', 'V', 'H', 'S']
			numbers = ('1'..'9').to_a
			space = [" "]
			invalid_first_characters = invalid_letters + numbers + space
			input_validator = InputValidator.new
			invalid_first_characters.each {|character| expect(input_validator.validate_line(character)).to eq('Error')}
		end

		it 'should only accept numbers between 1 and 250' do
			input_validator = InputValidator.new
			lines_with_out_of_bounds_numbers = ['I 251 6', 'L 1 0 C', 'V 2 300 6 W', 'H 3 5 0 Z']
			lines_with_out_of_bounds_numbers.each {|line| expect(input_validator.validate_line(line)).to eq('Error')}
		end

	end

end