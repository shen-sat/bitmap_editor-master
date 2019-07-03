class Processor
	attr_accessor :table

	def initialize
		@table = [] 
	end

	def process(line)
		case line[0]
		when 'I'
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
			if line.split(/ /)[1].to_i > @table[0].size || line.split(/ /)[2].to_i > @table.size
				return 'Error'
			end 
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
end