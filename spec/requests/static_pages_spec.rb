require 'spec_helper'

describe "StaticPages" do
  describe "GET /" do

    it "should have the content 'StaticPages#home'" do
      visit '/'
      page.should have_content('StaticPages#home')
    end

  end


  describe "GET /about" do
    it "should have content 'StaticPages#about'" do
      visit '/about'
      page.should have_content('StaticPages#about')
    end

  end

  describe "GET /contact" do
    it "should have content 'StaticPages#contact'" do
      visit '/contact'
      page.should have_content('StaticPages#contact')
    end

  end


end
