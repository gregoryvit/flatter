require "xcflatter/version"
require 'xcodeproj'
require 'fileutils'

module Flatter
  class Error < StandardError; end

  class FileMover

    # Move all files with specific extenstion from subfolders to root group
    def move_all_files_with_ext_to_root_group(project_path, dest_file_ext, root_group_path)
      project = Xcodeproj::Project.open(project_path)

      # Get root group
      if root_group_path.nil?
          root_group = project.main_group
      else
          root_group = project[root_group_path]
      end

      # Move files in FS
      base_dir_path = root_group.real_path.to_s

      # For each project file move to root group
      project.files.each do |file|
          file_ext = File.extname(file.path)
          if dest_file_ext == file_ext
              # Move files in FS hierarchy
              initial_path = file.real_path
              result_path = base_dir_path + '/' + File.basename(file.path)
              if result_path != initial_path
                  FileUtils.mv(initial_path, result_path)
              end

              # Fix and move files in Xcode hierarchy
              file.set_source_tree("<group>")
              file.set_path(File.basename(file.path))
              file.move(root_group)
          end
      end

      project.save()
    end

  end
end
