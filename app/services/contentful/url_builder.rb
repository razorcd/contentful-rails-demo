# use by chaining methods:
#      url = UrlBuilder.new("https://www.example.com")
#      url.with_access_token.with_initial_flag.to_s         # => https://www.example.com?access_token=fd98dsg0&initial=true
#
#      url.with_access_token                                # will keep the change until `#to_s` is called
#      url.to_s                                             # => https://www.example.com?access_token=fd98dsg0
#
#      url.to_s                                             # => https://www.example.com
#
#      url = UrlBuilder.new("https://www.example.com?a=1")
#      url.with_access_token.with_initial_flag.to_s         # => https://www.example.com?a=1&access_token=&initial=true
#      url.to_s                                             # => https://www.example.com?a=1?
class Contentful::UrlBuilder
  ACCESS_TOKEN = ENV["ACCESS_TOKEN"]

  def initialize url
    @url = url
    clear!
  end

  def with_access_token
    @query << "access_token=#{ACCESS_TOKEN}"
    self
  end

  def with_initial_flag
    @query << "initial=true"
    self
  end

  def to_s
    "#{@url}#{query_to_s}".tap { clear! }
  end

private

  def clear!
    @query = []
  end

  def query_to_s
    return "" if @query.empty?
    query = @query.join("&")
    @url.include?("?") ? query.insert(0, "&") : query.insert(0, "?")
    query
  end
end
