require_relative '../lib/input_validator'

describe 'InputValidator' do

	error_message = 'Incorrect input'

	context 'when validating individual lines of input,' do

		it 'should only accept two numbers following an I' do
			input_validator = InputValidator.new
			expect{ input_validator.validate_line('I A') }.to raise_error(error_message)
			expect{ input_validator.validate_line('I 5') }.to raise_error(error_message)
			expect{ input_validator.validate_line('I 5 B') }.to raise_error(error_message)
			expect{ input_validator.validate_line('I 5 6 6') }.to raise_error(error_message)
			expect{ input_validator.validate_line('I 5 6 A') }.to raise_error(error_message)
			expect{ input_validator.validate_line('I 5 6') }.to_not raise_error

		end

		it 'should only accept a single C' do
			input_validator = InputValidator.new
			expect{ input_validator.validate_line('C A') }.to raise_error(error_message)
			expect{ input_validator.validate_line('C 1') }.to raise_error(error_message)
			expect{ input_validator.validate_line('C') }.to_not raise_error
		end

		it 'should only accept two numbers and a letter following an L' do
			input_validator = InputValidator.new
			expect{ input_validator.validate_line('L A') }.to raise_error(error_message)
			expect{ input_validator.validate_line('L 1') }.to raise_error(error_message)
			expect{ input_validator.validate_line('L 1 B') }.to raise_error(error_message)
			expect{ input_validator.validate_line('L 1 3') }.to raise_error(error_message)
			expect{ input_validator.validate_line('L 1 3 A C') }.to raise_error(error_message)
			expect{ input_validator.validate_line('L 1 3 A 5') }.to raise_error(error_message)
			expect{ input_validator.validate_line('L 1 3 A') }.to_not raise_error
		end

		it 'should only accept three numbers and a letter following a V' do
			input_validator = InputValidator.new
			expect{ input_validator.validate_line('V A') }.to raise_error(error_message)
			expect{ input_validator.validate_line('V 2') }.to raise_error(error_message)
			expect{ input_validator.validate_line('V 2 A') }.to raise_error(error_message)
			expect{ input_validator.validate_line('V 2 3') }.to raise_error(error_message)
			expect{ input_validator.validate_line('V 2 3 A') }.to raise_error(error_message)
			expect{ input_validator.validate_line('V 2 3 6') }.to raise_error(error_message)
			expect{ input_validator.validate_line('V 2 3 6 7') }.to raise_error(error_message)
			expect{ input_validator.validate_line('V 2 3 6 W A') }.to raise_error(error_message)
			expect{ input_validator.validate_line('V 2 3 6 W 9') }.to raise_error(error_message)
			expect{ input_validator.validate_line('V 2 3 6 W') }.to_not raise_error
		end

		it 'should only accept three numbers and a letter following an H' do
			input_validator = InputValidator.new
			expect{ input_validator.validate_line('H A') }.to raise_error(error_message)
			expect{ input_validator.validate_line('H 3') }.to raise_error(error_message)
			expect{ input_validator.validate_line('H 3 A') }.to raise_error(error_message)
			expect{ input_validator.validate_line('H 3 5') }.to raise_error(error_message)
			expect{ input_validator.validate_line('H 3 5 A') }.to raise_error(error_message)
			expect{ input_validator.validate_line('H 3 5 2') }.to raise_error(error_message)
			expect{ input_validator.validate_line('H 3 5 2 7') }.to raise_error(error_message)
			expect{ input_validator.validate_line('H 3 5 2 Z A') }.to raise_error(error_message)
			expect{ input_validator.validate_line('H 3 5 2 Z 9') }.to raise_error(error_message)
			expect{ input_validator.validate_line('H 3 5 2 Z') }.to_not raise_error
		end

		it 'should only accept a single S' do
			input_validator = InputValidator.new
			expect{ input_validator.validate_line('S A') }.to raise_error(error_message)
			expect{ input_validator.validate_line('S 1') }.to raise_error(error_message)
			expect{ input_validator.validate_line('S') }.to_not raise_error
		end

		it 'should not accept symbols' do
			input_validator = InputValidator.new
			lines_with_symbols = ['I . 6', 'C ?', 'L 1 , C', 'V 2 3 - W', 'H 3 5 2 +', '! S']
			lines_with_symbols.each {|line| expect{ input_validator.validate_line(line) }.to raise_error(error_message)}
		end

		it 'should not accept lowercase letters' do
			input_validator = InputValidator.new
			lines_with_lowercase_letters = ['i 5 6', 'c', 'l 1 3 C', 'v 2 3 6 W', 'H 3 5 2 z', 's']
			lines_with_lowercase_letters.each {|line| expect{ input_validator.validate_line(line) }.to raise_error(error_message)}
		end

		it 'should not accept double spaces' do
			input_validator = InputValidator.new
			lines_with_lowercase_letters = ['I  5 6', 'C  ', 'L 1  3 C', 'V 2 3  6 W', 'H 3 5 2  Z', '  S']
			lines_with_lowercase_letters.each {|line| expect{ input_validator.validate_line(line) }.to raise_error(error_message)}
		end

		it 'should only accept I, C, L, V, S as the first character' do
			invalid_letters = ('A'..'Z').to_a - ['I', 'C', 'L', 'V', 'H', 'S']
			numbers = ('1'..'9').to_a
			space = [" "]
			invalid_first_characters = invalid_letters + numbers + space
			input_validator = InputValidator.new
			invalid_first_characters.each {|character| expect{ input_validator.validate_line(character) }.to raise_error(error_message)}
		end

		it 'should only accept numbers between 1 and 250' do
			input_validator = InputValidator.new
			lines_with_out_of_bounds_numbers = ['I 251 6', 'L 10 0 C', 'V 2 300 6 W', 'H 3 5 0 Z']
			lines_with_within_bounds_numbers = ['I 250 6', 'L 10 1 C', 'V 1 1 1 W', 'H 250 250 250 Z']
			lines_with_out_of_bounds_numbers.each {|line| expect{ input_validator.validate_line(line) }.to raise_error(error_message)}
			lines_with_within_bounds_numbers.each {|line| expect{ input_validator.validate_line(line) }.to_not raise_error}
		end

	end

end