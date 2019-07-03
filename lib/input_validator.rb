class InputValidator
	def initialize
		create_grid = Regexp.new(/^I( [1-9]| [1-8][0-9]| 9[0-9]| 1[0-9]{2}| 2[0-4][0-9]| 250){2}$/)
		clear_grid = Regexp.new(/^C$/)
		colour_pixel = Regexp.new(/^L( [1-9]| [1-8][0-9]| 9[0-9]| 1[0-9]{2}| 2[0-4][0-9]| 250){2} [A-Z]$/)
		vertical_rect = Regexp.new(/^V( [1-9]| [1-8][0-9]| 9[0-9]| 1[0-9]{2}| 2[0-4][0-9]| 250){3} [A-Z]$/)
		horizontal_rect = Regexp.new(/^H( [1-9]| [1-8][0-9]| 9[0-9]| 1[0-9]{2}| 2[0-4][0-9]| 250){3} [A-Z]$/)
		show_contents = Regexp.new(/^S$/)
		@regexes = [create_grid, clear_grid, colour_pixel, vertical_rect, horizontal_rect, show_contents]
	end

	def validate_line(line)
		match_found = false
		@regexes.each { |regex| match_found = true if line.match(regex) }
		raise 'Incorrect input' if match_found == false
	end
end