module Rapidoc

  ##
  # This class open controller file and get all documentation blocks.
  # Lets us check if any of this blocks is a `rapidoc` block
  # and return it using `json` format.
  #
  # Rapidoc blocks must:
  # - have YAML format
  # - begin with `#=begin action` for actions description
  # - begin with `#=begin resource` for resource description
  # - end with `#=end`
  #
  class ControllerExtractor

    def initialize( controller_file )
      @docs_extracted = false
      @controller_file = controller_file
    end

    def docs_extracted?
      @docs_extracted
    end

    def description
      extract_docs! unless docs_extracted?
      @resource_info["description"]
    end

    def actions
      extract_docs! unless docs_extracted?
      @actions_info
    end

    def get_actions_info
      puts @actions_info.inspect
      @actions_info
    end

    def get_action_info( action )
      @actions_info.select{ |info| info['action'] == action.to_s }.first
    end

    def get_resource_info
      @resource_info
    end

    def get_controller_info
      { "description" => @resource_info["description"], "actions" => @actions_info }
    end

    private

    def extract_docs!
      lines = IO.readlines( @controller_file )
      blocks = extract_blocks( lines )
      @resource_info = YamlParser.extract_resource_info( lines, blocks, @controller_file )
      @actions_info = YamlParser.extract_actions_info( lines, blocks, @controller_file )
      @docs_extracted = true
    end

    ##
    # Gets init and end lines of each comment block
    #
    def extract_blocks( lines )
      init_doc_lines = lines.each_index.select{ |i| lines[i].include? "=begin" }
      end_doc_lines = lines.each_index.select{ |i| lines[i].include? "=end" }

      blocks = init_doc_lines.each_index.map do |i|
        { :init => init_doc_lines[i], :end => end_doc_lines[i] }
      end
    end
  end
end
