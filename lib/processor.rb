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
			single_row = []
			number_of_columns.times { single_row << 'O' }
			number_of_rows.times { @table << Array.new(single_row) }
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
			row_index_start = line.split(/ /)[2].to_i - 1
			row_index_finish = line.split(/ /)[3].to_i - 1 
			color = line.split(/ /)[4]
			(row_index_start..row_index_finish).each { |row_index| @table[row_index][column_index] = color }
		when 'H'
			column_index_start = line.split(/ /)[1].to_i - 1
			column_index_finish = line.split(/ /)[2].to_i - 1
			row_index = line.split(/ /)[3].to_i - 1
			color = line.split(/ /)[4]
			(column_index_start..column_index_finish).each { |column_index| @table[row_index][column_index] = color }
		end
	end
end