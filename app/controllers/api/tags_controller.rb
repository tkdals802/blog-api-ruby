class Api::TagsController < ApplicationController
  skip_before_action :verify_authenticity_token

  # GET /tags
  def index
    @tags = Tag.all
    render json: @tags
  end

  # GET /tags/:tag_id
  def show
    @tags = Tag.find(params[:id])
    render json: @tags
  end

  # def create
  #   tag_names = params[:tags][:names]
  #
  #   tag_names.each do |tag_name|
  #     tag = Tag.find_or_create_by(name: tag_name)
  #   end
  #
  #   render json: {message: 'Tag successfully created'}, status: 200
  # end

  # DELETE /tags/:tag_id
  def destroy
    @tags = Tag.find(params[:id])
    if @tags
      @tags.destroy
      render json: { message: "delete tag success" }, status: 200
    else
      render json: { error: "Unable find tags" }, status: 400
    end
  end

  # GET /tags/:tag_id/articles
  # 一つのtagが持っているarticleを検索
  def show_articles
    @tag = Tag.find_by(id: params[:tag_id])
    if @tag
      @articles = @tag.articles
      render json: {
        message: "get tag and articles successfully",
        articles: @articles
      }, status: 200
    else
      render json: { error: "No such tag" }, status: 400
    end
  end

  private

  def tag_param
    params.require(:tags).permit(:name)
  end
end
