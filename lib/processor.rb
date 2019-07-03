class Processor
	attr_accessor :table

	def initialize
		@table = [] 
	end

	def process(line)
		converted_line = convert_line(line)
		if converted_line[0] != 'I'
			check_table_exists
			check_out_of_bounds(line)
		end
		case converted_line[0]
		when 'I'
			@table = []
			number_of_columns = converted_line[1]
			number_of_rows = converted_line[2]
			number_of_rows.times { @table << Array.new(Array.new(number_of_columns, 'O')) }
		when 'C'
			@table.each do |row|
				row.collect! { |pixel| pixel = 'O' }
			end
		when 'L'
			column_index = converted_line[1] - 1
			row_index = converted_line[2] - 1
			color = converted_line[3] 
			@table[row_index][column_index] = color
		when 'V'
			column_index = converted_line[1] - 1
			if converted_line[2] < converted_line[3]
				row_index_start = converted_line[2] - 1
				row_index_finish = converted_line[3] - 1 
			else
				row_index_start = converted_line[3] - 1
				row_index_finish = converted_line[2] - 1 
			end 
			color = converted_line[4]
			(row_index_start..row_index_finish).each { |row_index| @table[row_index][column_index] = color }
		when 'H'
			if converted_line[1] < converted_line[2]
				column_index_start = converted_line[1] - 1
				column_index_finish = converted_line[2] - 1
			else
				column_index_start = converted_line[2] - 1
				column_index_finish = converted_line[1] - 1
			end 
			row_index = converted_line[3] - 1
			color = converted_line[4]
			(column_index_start..column_index_finish).each { |column_index| @table[row_index][column_index] = color }
		end
	end

	def check_out_of_bounds(line)
		row_limit = @table.size
		column_limit = @table[0].size
		case line[0]
		when 'L'
			if line.split(/ /)[1].to_i > column_limit || line.split(/ /)[2].to_i > row_limit
				raise 'Input is out of bounds of table'
			end
		when 'H'
			if line.split(/ /)[1].to_i > column_limit || line.split(/ /)[2].to_i > column_limit || line.split(/ /)[3].to_i > row_limit
				raise 'Input is out of bounds of table'
			end
		when 'V'
			if line.split(/ /)[1].to_i > column_limit || line.split(/ /)[2].to_i > row_limit || line.split(/ /)[3].to_i > row_limit
				raise 'Input is out of bounds of table'
			end
		end
	end

	def check_table_exists
		raise 'Table not created. Please enter an "I" input at beginning of file' if @table.empty?
	end

	def convert_line(line)
		characters = line.split(/ /)
		characters.collect! do |character|
			character.match(/\d/) ? character = character.to_i : character
		end
	end
end