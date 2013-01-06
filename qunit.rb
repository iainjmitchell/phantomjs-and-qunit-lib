class QunitConfiguration
	attr_accessor :phantom_exe, :qunit_runner, :test_directory
end

def qunit(*args, &block)
	configuration = QunitConfiguration.new;
	task = Proc.new{ 
		p "Qunit starting..."
		block.call(configuration)
		sh "#{configuration.phantom_exe} #{configuration.qunit_runner} #{configuration.test_directory}/*.html"
		p "Qunit run completed"
	};
	Rake::Task.define_task(*args, &task)
end