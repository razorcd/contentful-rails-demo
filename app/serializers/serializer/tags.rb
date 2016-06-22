  class Serializer::Tags
    def initialize tags
      @tags = tags.to_a
    end

    def as_json options = {}
      @tags.map(&:value)
    end
  end
