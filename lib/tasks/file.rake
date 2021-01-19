
namespace :file do
  desc "Create example file"
  task :create_example do
    gitignore = File.open Rails.root.join(".gitignore"), "a"

    file_names = ["config/database.yml"]

    file_names.each do |file|
      FileUtils.cp file, file + ".example"
      gitignore << file + "\n"
    end

    gitignore.close
  end
  
  desc "Remove default comments"
  task :rm_comment_gemfile do
    file_names = ["Gemfile", "config/application.rb"]

    file_names.each do |file_name|
      text = File.read file_name
      
      # Xoa comment
      new_contents = text.gsub(/^\s*#.*/, "")
      # Chuyen nhay don => nhay kep 
      new_contents.gsub!(/'/, '"')

      puts new_contents
      File.open(file_name, "w") {|file| file.puts new_contents }
    end
  end
end
