class InputValidator

	def validate_character(character)
		if character =~ /[^A-Z1-9]/
			return 'Error'
		end
	end
end