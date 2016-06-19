# use:
#   sync_url = Contentful::SyncUrl.new  # - sigleton object (always returns the same instance)
#   sync_url.get       # => https://cdn.contentful.com/spaces/space123space/sync?access_token=fd98dsg0&initial=true
#   sync_url.set_next(url: "https://cdn.contentful.com?sync_token=cvo8dsav98usd")  # => will be persisted
#   sync_url.get       # => https://cdn.contentful.com?sync_token=cvo8dsav98usd&access_token=fd98dsg0
#
#   sync_url.reset! or Contentful::SyncUrl.new.reset!
#   sync_url.get       # => https://cdn.contentful.com/spaces/space123space/sync?access_token=fd98dsg0&initial=true
class Contentful::SyncUrl
  INITIAL_URL= ENV["INITIAL_PRODUCTS_URL"]
  NEXT_URL_FILE = ENV["NEXT_URL_FILE"]

  class Contentful::SyncUrl::Sigleton
    def initialize
      persisted_url = read_persisted_next_url
      @next_url = Contentful::UrlBuilder.new(persisted_url || INITIAL_URL)
      @initial = persisted_url.!
    end

    def get
      if @initial
        @next_url.with_access_token.with_initial_flag.to_s
      else
        @next_url.with_access_token.to_s
      end
    end

    def set_next url:
      @next_url = Contentful::UrlBuilder.new url
      @initial = false
      write_persisted_next_url(url)
    end

    def reset!
      @next_url = Contentful::UrlBuilder.new INITIAL_URL
      @initial = true
      clear_persisted_next_url
    end

  private

    def read_persisted_next_url
      return unless File.exists?(NEXT_URL_FILE)
      file = File.open(NEXT_URL_FILE, 'r')
      file.read.chomp.tap { file.close }
    rescue
      file.close
    end

    def write_persisted_next_url url
      file = File.open(NEXT_URL_FILE, 'w')
      file.puts url
    ensure
      file.close
    end

    def clear_persisted_next_url
      file = File.open(NEXT_URL_FILE, 'w')
    ensure
      file.close
    end
  end

  def self.new
    @@instace||= Contentful::SyncUrl::Sigleton.new
  end
end
