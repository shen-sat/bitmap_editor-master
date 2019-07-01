class InputValidator

	def validate_line(line)
		if line[0] =~ /[^ICLVHS]/
			return 'Error'
		end
		if line[0] == 'I'
			if line !~ /^I [1-9] [1-9]$/
				return 'Error'	
			end
		end
		if line[0] == 'C'
			if line !~ /^C$/
				return 'Error'	
			end
		end
		if line[0] == 'L'
			if line !~ /^L [1-9] [1-9] [A-Z]$/
				return 'Error'	
			end
		end
		if line[0] == 'V'
			if line !~ /^V [1-9] [1-9] [1-9] [A-Z]$/
				return 'Error'	
			end
		end
		if line[0] == 'H'
			if line !~ /^H [1-9] [1-9] [1-9] [A-Z]$/
				return 'Error'	
			end
		end
		if line[0] == 'S'
			if line !~ /^S$/
				return 'Error'	
			end
		end
	end
end