class QunitConfiguration
	attr_accessor :phantom_exe, :qunit_runner, :test_directory
end

def qunit(*args, &block)	
	qunit_wrapper = Qunit_Wrapper.new(&block)
	task = Proc.new { qunit_wrapper.run }
	Rake::Task.define_task(*args, &task)
end

class Qunit_Wrapper
	def initialize(&block)
		@block = block;
	end
	
	def run()			
		config = QunitConfiguration.new		
		@block.call(config)		
		Dir.glob("#{config.test_directory}/*.html") do |test_file|			
			puts "testing  #{test_file}"	
			system "\"#{config.phantom_exe}\" \"#{config.qunit_runner}\" \"#{test_file}\""  		
		end						
	end
end