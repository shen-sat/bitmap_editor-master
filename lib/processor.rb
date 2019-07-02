class Processor
	attr_accessor :table

	def initialize
		@table = [] 
	end

	def process(line)
		number_of_columns = line[1].to_i
		number_of_rows = line[2].to_i
		#TODO get single_row onm one line?
		single_row = []
		number_of_columns.times { single_row << 'O' }
		number_of_rows.times { @table << single_row }
	end
end