require 'FileUtils'

class Robotnik
  class << self
    attr_accessor :stylesheet_compression, :stylesheets_to_merge, :robotniks_path
    
    def compress
      yield(self)
      start_compressing_css
    end
    
    def master_stylesheet_path(master_stylesheet_name)
      "#{robotniks_path}/robotnik/css/#{master_stylesheet_name}"
    end
    
    private
    
    def start_compressing_css
      stylesheets_to_merge.each_pair do |key,values|
        key = "#{key}.css"
        merge_and_compress_css(key, values)
      end
    end
    
    def merge_and_compress_css(master_name, stylesheets)
      validate_stylesheets_exists(stylesheets)
            
      create_robotniks_paths
          
      File.open(master_stylesheet_path(master_name), 'w+') do |file|
        
        stylesheets.each do |css_file|
          File.open(css_file) do |f| 
            f.each_line do |line| 
              if stylesheet_compression
                file.write line.gsub(/\s+/, '')
              else
                file.write line
              end # if stylesheet_compressed
            end # f.each_line
            
            file.write "\n" unless stylesheet_compression
            
          end # File.open(css_file)
        end # css_files.each
        
      end # File.open(master_stylesheet_name)
    end
    
    def validate_stylesheets_exists(stylesheets)
      stylesheets.each {|path| raise "Can't find the file #{path}" unless File.exist?(path)}
    end
    
    def create_robotniks_paths
      FileUtils.mkdir_p "#{robotniks_path}/robotnik/css"
    end
        
  end
end