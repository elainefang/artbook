class ArtworksController < ApplicationController
  before_action :require_current_user, except: [:index, :show, :new, :create, :edit, :update, :destroy, :search]
  before_action(:load_user, only: [:index, :new, :create, :show, :edit, :update, :destroy] )
  before_action(:load_artwork, { only: [:edit, :update, :show, :destroy] })

  def index
    page_user = User.find_by(id: params[:user_id])
    @artworks = page_user.artworks
  end

  def show
    if params[:user_id]
      @page_user = User.find_by(id: params[:user_id])
      @artwork = Artwork.find(params[:id])
    end
  end

  def new
    @artwork = Artwork.new
  end

  def create
    @artwork = Artwork.new(artwork_params)
    @artwork.user = @user
    @artwork.save

    redirect_to user_artwork_path(@user, @artwork)
  end

  def edit
  end

  def update
    @artwork.update(artwork_params)
    redirect_to user_artwork_path(@user, @artwork)
  end

  def destroy
    if params[:user_id]
      Artwork.find(params[:id]).destroy
      redirect_to user_artworks_path(@user)
    end
  end

  def search
    @search_terms = params[:q].downcase.split(" ")
    @all_artwork = Artwork.all

    @results = @all_artwork.select do |artwork|

      title_words = artwork.title.downcase.gsub(/[^a-z0-9\s]/i, '').split(" ")

      description_words = artwork.description.downcase.gsub(/[^a-z0-9\s]/i, '').split(" ")

      !(title_words & @search_terms).empty? || !(description_words & @search_terms).empty?
    end

  end


  private

    def load_user
      return @user = User.find_by(id: params[:user_id])
    end

    def load_artwork
    return @artwork = Artwork.find_by(id: params[:id])
    end

    def artwork_params
      params.require(:artwork).permit(:title, :description, :image_url, :art_image, :user_id)
    end

    def require_current_user
      if !current_user?(@user)
        redirect_to root_path
      end
    end

end
