begin  
  require 'FileUtils'
rescue LoadError
  require 'fileutils'
end

class Robotnik
  class << self
    attr_accessor :stylesheet_compression, :stylesheets_to_merge, :robotniks_path
    
    def compress
      yield(self)
      start_compressing_css
    end
    
    def master_stylesheet_path(master_stylesheet_name)
      "#{robotniks_path}/#{master_stylesheet_name}"
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
            
      File.open(master_stylesheet_path(master_name), 'w+') do |file|
        
        stylesheets.each do |css_file|
          File.open(css_file) do |f| 
            f.each_line do |line| 
              if stylesheet_compression
                file.write compress_css(line)
              else
                file.write line
              end # if stylesheet_compressed
            end # f.each_line
            
            file.write "\n" unless stylesheet_compression
            
          end # File.open(css_file)
        end # css_files.each
        
      end # File.open(master_stylesheet_name)
    end
    
    def compress_css(line)
      line.gsub!(/\n+/, '')     # Remove any newlines
      line.gsub!(/\t+/, '')
      line.gsub!(/\s{2,}/, ' ')   # Remove any gaps larger than 2 spaces
      line
    end
    
    def validate_stylesheets_exists(stylesheets)
      stylesheets.each {|path| raise "Can't find the file #{path}" unless File.exist?(path)}
    end
            
  end
end