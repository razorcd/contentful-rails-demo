class Serializer::Category
  def initialize category
    @category = category
  end

  def as_json options = {}
    {
      id: @category.id,
      remote_id: @category.remote_id,
      title: @category.title,
      description: @category.description,
    }
  end
end
