require "rails_helper"

RSpec.describe Contentful::UrlBuilder do
  subject { Contentful::UrlBuilder }

  context "#to_s" do
    it "should return initialized url" do
      expect(subject.new("https://www.example.com").to_s).to eq "https://www.example.com"
    end
  end

  context "#with_access_token" do
    it "should add access token to url" do
      url = subject.new("https://www.example.com").with_access_token.to_s
      expect(url).to match /[^https:\/\/www.example.com?access_token=][a-zA-Z0-9]*/
    end
  end

  context "#with_initial_flag" do
    it "should add initial flag to url" do
      url = subject.new("https://www.example.com").with_initial_flag.to_s
      expect(url).to eq "https:\/\/www.example.com?initial=true"
    end
  end

  context "method chain" do
    it "should add initial flag to url" do
      url = subject.new("https://www.example.com").with_access_token.with_initial_flag.to_s
      expect(url).to match /[^https:\/\/www.example.com?access_token=][a-zA-Z0-9]*[&initial=true&]/
    end
  end
end
