class InputValidator

	def validate_character(character)
		if character =~ /[^INMCLVHS1-9]/
			return 'Error'
		end
	end
end