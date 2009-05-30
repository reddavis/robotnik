require 'test/unit'
require 'FileUtils'
require File.dirname(__FILE__) + '/../lib/robotnik'

class TestRobotnik < Test::Unit::TestCase
  
  def setup
    Dir["#{File.dirname(__FILE__)}/test_examples/robotnik/css/*.css"].each do |file|
      FileUtils.rm file
    end
  end
    
  def test_that_a_master_css_file_is_created
    create_compression
    assert_equal(File.exists?(@master_css_paths[0]), true )
  end
 
  def test_that_css_file_gets_compressed
    create_compression(:stylesheets_to_merge => {:master_compressed =>
                ["#{File.dirname(__FILE__)}/test_examples/css/to_compress.css"]
    })
    
    @master_css_paths.each do |path|
      File.open(path) do |file|
        while line = file.gets
          assert_no_match(/\s{2,}/, line)
          assert_no_match(/\n+/, line)
          assert_no_match(/\t+/, line)
        end
      end
    end
  end
  
  def test_that_css_file_does_not_get_compressed
    create_compression(:stylesheet_compression => false, 
                       :stylesheets_to_merge => {:master_un_compressed =>
                                   ["#{File.dirname(__FILE__)}/test_examples/css/to_compress.css"]
                       })
    @master_css_paths.each do |path|
      File.open(path) do |file|
        assert_match(/\s+/, file.gets)  # Just checks the first line has a \n
      end
    end
  end
  
  def test_that_css_files_are_being_merged_correctly_with_compression
    create_compression(:stylesheets_to_merge => {
                                  :compressed => [
                                      "#{File.dirname(__FILE__)}/test_examples/css/first.css",
                                      "#{File.dirname(__FILE__)}/test_examples/css/second.css"
                                    ]
                      })
    File.open(@master_css_paths[0]) do |file|
      assert_match(/#first \{color:black;\}\.second \{border:solid 1px black;\}/, file.gets)
    end
  end
  
  def test_that_css_files_are_being_merged_correctly_without_compression
    create_compression(:stylesheets_to_merge => {
                                  :un_compressed => [
                                      "#{File.dirname(__FILE__)}/test_examples/css/first.css",
                                      "#{File.dirname(__FILE__)}/test_examples/css/second.css"
                                    ]
                      }, :stylesheet_compression => false)

    File.open(@master_css_paths[0]) do |file|
      assert_match(/#first \{\n\tcolor:black;\n\}\n.second \{border:solid 1px black;\}\n/, file.readlines.join)
    end
  end
 
  private
  
  def create_compression(user_options={})
    @options = {
               :robotniks_path => "#{File.dirname(__FILE__)}/test_examples/css",
               :stylesheets_to_merge => {
                                :master => Dir["#{File.dirname(__FILE__)}/test_examples/css/*.css"]
                                      },
               :stylesheet_compression => true
              }.merge!(user_options)
              
    @master_css_paths = master_css_paths(@options[:stylesheets_to_merge])
    
    Robotnik.compress do |c|
      c.robotniks_path = @options[:robotniks_path]
      c.stylesheets_to_merge = @options[:stylesheets_to_merge]
      c.stylesheet_compression = @options[:stylesheet_compression]
    end
  end
  
  def master_css_paths(stylesheets_to_compress)
    paths = []
    stylesheets_to_compress.each_key do |filename|
      paths << "#{@options[:robotniks_path]}/#{filename}.css"
    end
    paths
  end
  
end