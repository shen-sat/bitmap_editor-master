class InputValidator

	def validate_character(character)
		if character =~ /[^A-Z1-9]/
			return 'Error'
		end
	end

	def validate_line(line)
		if line[0] =~ /[^ICLVS]/
			return 'Error'
		end
		if line =~ /  /
			return 'Error'
		end
		line.split(' ').each do |line_chunk|
			if line_chunk.size > 1
				return 'Error'
			end
		end
		if line[0] == 'I'
			if line !~ /^I [1-9] [1-9]$/
				return 'Error'	
			end
		end
	end
end