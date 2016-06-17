require "rails_helper"

RSpec.describe Contentful::SyncUrl do
  subject { Contentful::SyncUrl }

  it "should be a sigleton" do
    obj1 = subject.new
    obj2 = subject.new
    expect(obj1.object_id).to eq obj2.object_id
  end

  context "#get" do
    it "should return a string with access token" do
      expect(subject.new.get).to be_a String
      expect(subject.new.get).to match /[^http:\/\/www.].*[\?access_token=].*/
    end
  end

  context "#set_next" do
    it "should set new url" do
      sync_url = subject.new
      sync_url.set_next(url: "http://www.example.com")
      expect(sync_url.get).to match /[^http:\/\/www.example.com?sync_token=][a-zA-Z0-9]*/
    end
  end

  context "#reset" do
    before :each do
      @sync_url = subject.new
      @sync_url.set_next(url: "http://www.example.com")
    end

    it "should set default url" do
      @sync_url.reset!
      expect(@sync_url.get).to include Contentful::SyncUrl::Sigleton::INITIAL_URL + "?access_token="
    end

    it "should set default url by calling #new again" do
      subject.new.reset!
      expect(@sync_url.get).to include Contentful::SyncUrl::Sigleton::INITIAL_URL + "?access_token="
    end
  end

  describe "persisting the sync_url in a file" do
    let(:filename) { Contentful::SyncUrl::Sigleton::NEXT_URL_FILE }

    before :each do
      File.delete filename
    end

    it "should initialize from file" do
      File.open(filename, "w") do |file|
        file.write "http://www.initialize_from_file_example.com"
      end
      sync_url = subject.dup.new
      expect(sync_url.get).to match /[^http:\/\/www.initialize_from_file_example.com?sync_token=][a-zA-Z0-9]*/
    end

    it "should persist when setting #next_url" do
      sync_url = subject.new
      sync_url.set_next(url: "http://www.example.com")

      File.open(filename) do |file|
        expect(file.read.chomp).to eq "http://www.example.com"
      end
    end

    it "should clear file when calling #reset" do
      sync_url = subject.new
      sync_url.set_next(url: "http://www.example.com")
      subject.new.reset!

      File.open(filename) do |file|
        expect(file.read.chomp).to eq ""
      end
    end
  end
end
