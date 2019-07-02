class Processor
	attr_accessor :table

	def initialize
		@table = [] 
	end

	def process(line)
		case line[0]
		when 'I'
			number_of_columns = line[1].to_i
			number_of_rows = line[2].to_i
			#TODO get single_row onm one line?
			single_row = []
			number_of_columns.times { single_row << 'O' }
			number_of_rows.times { @table << single_row }
		when 'C'
			@table.each do |row|
				row.collect! { |pixel| pixel = 'O' }
			end
		when 'L'
			column_index = line[1].to_i - 1
			row_index = line[2].to_i - 1
			color = line[3]
			@table[row_index][column_index] = color
		end
	end
end