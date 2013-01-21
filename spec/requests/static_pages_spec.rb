require 'spec_helper'

describe "StaticPages" do
  describe "GET /" do

    it "should have the content 'StaticPages#home'" do
      visit '/'
      page.should have_content('StaticPages#home')
    end

  end


  describe "GET /about" do
    it "should ahve content 'StaticPages#about'" do
      visit '/about'
      page.should have_content('StaticPages#about')
    end

  end
end
