class Processor
	attr_accessor :table

	def initialize
		@table = [] 
	end

	def process(line)
		convert_line = convert_line(line)
		if line[0] != 'I'
			check_table_exists
			check_out_of_bounds(line)
		end
		case line[0]
		when 'I'
			@table = []
			number_of_columns = line.split(/ /)[1].to_i
			number_of_rows = line.split(/ /)[2].to_i
			number_of_rows.times { @table << Array.new(Array.new(number_of_columns, 'O')) }
		when 'C'
			@table.each do |row|
				row.collect! { |pixel| pixel = 'O' }
			end
		when 'L'
			column_index = line.split(/ /)[1].to_i - 1
			row_index = line.split(/ /)[2].to_i - 1
			color = line.split(/ /)[3] 
			@table[row_index][column_index] = color
		when 'V'
			column_index = line.split(/ /)[1].to_i - 1
			if line.split(/ /)[2].to_i < line.split(/ /)[3].to_i
				row_index_start = line.split(/ /)[2].to_i - 1
				row_index_finish = line.split(/ /)[3].to_i - 1 
			else
				row_index_start = line.split(/ /)[3].to_i - 1
				row_index_finish = line.split(/ /)[2].to_i - 1 
			end 
			color = line.split(/ /)[4]
			(row_index_start..row_index_finish).each { |row_index| @table[row_index][column_index] = color }
		when 'H'
			if line.split(/ /)[1].to_i < line.split(/ /)[2].to_i
				column_index_start = line.split(/ /)[1].to_i - 1
				column_index_finish = line.split(/ /)[2].to_i - 1
			else
				column_index_start = line.split(/ /)[2].to_i - 1
				column_index_finish = line.split(/ /)[1].to_i - 1
			end 
			row_index = line.split(/ /)[3].to_i - 1
			color = line.split(/ /)[4]
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