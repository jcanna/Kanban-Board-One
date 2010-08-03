require 'ftools'

task :build do

    source = "C:\\Documents and Settings\\pyp88231\\My Documents\\Flex Builder 3\\kanban_flex\\bin-debug"
    target = "C:\\Documents and Settings\\pyp88231\\My Documents\\Flex Builder 3\\kanban_rails\\public"
    
    Dir.foreach(source) { |filename|
      qualified_name = File.join(source,filename)
      File.copy(qualified_name, target) unless File.directory?(qualified_name)
    }

end