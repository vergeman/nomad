class StaticPagesController < ApplicationController

  def home
    if current_user
      redirect_to map_path
    end

  end

  def about
  end

  def contact
  end

end
