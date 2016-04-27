require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

module Skel
  module Tasks
    def exec_cmd(cmd)
      puts cmd.to_s
      `#{cmd}`
    end

    def inplace_replace(src, name)
      tmpfile = '/tmp/skel_' + rand(10_000_000).to_s
      out = File.open(tmpfile, 'a+')

      File.open(src, 'r').each_line do |l|
        l.chomp!
        l.gsub!(/Skel/, name.capitalize)
        l.gsub!(/skel/, name)
        out.puts l
      end

      if src =~ /skel/
        new_src = src.gsub(/skel/, name)
        new_src_dir = File.dirname(new_src)
        exec_cmd("mkdir -p #{new_src_dir}") unless File.exist?(new_src_dir)
        exec_cmd("mv #{tmpfile} #{new_src} ")
        exec_cmd("rm #{src}")
        src = new_src
      else
        exec_cmd("mv #{tmpfile} #{src}")
       end

      exec_cmd("chmod +x #{src}") if src =~ /bin\//
    end

    def file_action(file, name)
      return if file == __FILE__
      return if file =~ /Rakefile/
      inplace_replace(file, name)
    end

    def dir_file_crawl(dir, name)
      Dir.entries(dir).each do |f|
        next if f =~ /^\.{1,2}$/
        next if f =~ /^.git$/
        path = dir + '/' + f
        File.directory?(path) ? dir_file_crawl(path, name) : file_action(path, name)
      end
    end

    def dir_crawl(dir, name)
      Dir.entries(dir).each do |f|
        next if f =~ /^\.{1,2}$/
        next if f =~ /^.git$/
        next unless File.directory?(f)
        path = dir + '/' + f
        if path =~ /skel/
          exec_cmd("rm -rf #{path}")
        else
          dir_crawl(path, name)
        end
      end
    end
  end
end

RSpec::Core::RakeTask.new(:spec)

task :rename do
  include Skel::Tasks
  name = File.basename(Dir.pwd)
  Skel::Tasks.dir_file_crawl('.', name)
  Skel::Tasks.dir_crawl('.', name)
  Skel::Tasks.exec_cmd('rm -rf .git && git init') if File.exist?('.git')
  Skel::Tasks.exec_cmd('rm -rf .idea') if File.exist?('.idea')
end

task default: :spec

task test: :spec
