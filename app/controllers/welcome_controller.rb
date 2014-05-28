class WelcomeController < ApplicationController

  def index
    @user = current_user
  end

  def random
    @all_artworks = Artwork.all

  end

end
