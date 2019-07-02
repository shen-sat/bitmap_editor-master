class Processor
	attr_accessor :table

	def initialize
		@table = [] 
	end

	def process(line)
		row_size = line[1].to_i
		number_of_rows = line[2].to_i
		empty_array = []
		row_size.times do
			empty_array << 'O'
		end
		number_of_rows.times do
			@table << empty_array
		end
	end
end