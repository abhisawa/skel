require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

module Skel
    module Tasks
        def inplace_replace(src,name)
          tmpfile='/tmp/skel_' + "#{rand(10000000)}"
          out = File.open(tmpfile,'a+')

          File.open(src,'r').each_line do |l|
            l.chomp!
            l.gsub!(/Skel/,name.capitalize)
            l.gsub!(/skel/,name)
            out.puts l
          end   

           if src.match(/skel/)
                new_src = src.gsub(/skel/,name)
                new_src_dir = File.dirname(new_src)
                puts "mkdir -p #{new_src_dir}"
                `mkdir -p #{new_src_dir}` unless File.exists?(new_src_dir)
                puts "mv #{tmpfile} #{new_src}"
                `mv #{tmpfile} #{new_src} `
                puts "rm #{src}"
                `rm #{src}`
                src = new_src 
           else
                puts "mv #{tmpfile} #{src}"
                `mv #{tmpfile} #{src}` 
           end  

            if src.match(/bin\//)
                puts "chmod +x #{src}"
                `chmod +x #{src}`
            end
        end

        def file_action(file,name)
            return  if file == __FILE__
            return  if file.match(/Rakefile/)
            inplace_replace(file,name)
        end


        def dir_file_crawl(dir,name)
            Dir.entries(dir).each do |f|
                next if f.match(/^\.{1,2}$/) 
                next if f.match(/^.git$/)
                path = dir + '/' + f
                File.directory?(path) ?  ( dir_file_crawl(path,name) ) : ( file_action(path,name) )
            end
        end

        def dir_crawl(dir,name)
            Dir.entries(dir).each do |f|
                next if f.match(/^\.{1,2}$/) 
                next if f.match(/^.git$/)
                next unless File.directory?(f)
                path = dir + '/' + f
                if path.match(/skel/)
                    puts "rm -rf #{path}"
                    `rm -rf #{path}`
                else
                    dir_crawl(path,name)
                end
                
            end
        end
    end
end



RSpec::Core::RakeTask.new(:spec)

task :rename do
    include Skel::Tasks
    name = File.basename(Dir.pwd)
    Skel::Tasks.dir_file_crawl('.',name)    
    Skel::Tasks.dir_crawl('.',name)
end


task default: :spec

task test: :spec
