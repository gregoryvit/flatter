require 'optparse'
require 'flatter'

module Flatter
    class CLI

        def start
            options = {}
            OptionParser.new do |opts|
            opts.banner = "Usage: flatter PATH_TO_XCODEPROJ [options]"

            opts.on("-g String", String, "Path to root group") do |group_path|
                options[:group_path] = group_path
            end

            options[:files_ext] = ".swift"
            opts.on("-e String", String, "File extension. Default: .swift") do |files_ext|
                prefix = files_ext.start_with?(".") ? "" : "."
                options[:files_ext] = prefix + files_ext
            end
            end.parse!

            if ARGV.any?
                project_path = ARGV.first
                dest_file_ext = options[:files_ext]
                root_group_path = options[:group_path]
                Flatter::FileMover.new.move_all_files_with_ext_to_root_group(project_path, dest_file_ext, root_group_path)
            else
                puts "🛑 Error: Not arguments passed"
            end
        end
  
    end
  end