class Api::ArticlesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :create, :destroy, :update, :add_tags ]


  def index
    @articles = Article.includes(:tags, :category).all # category도 함께 포함
    articles_with_category = @articles.map do |article|
      {
        article: article,
        category_name: article.category.name, # 각 article에서 category_name을 가져옴
        tags: article.tags # 태그도 함께 포함
      }
    end

    render json: {
      message: "get articles successfully",
      articles: articles_with_category,
      include: [ "tags", "category" ]
    }
  end

  def show
    @article = Article.find_by(id: params[:id])

    if @article
      @category = Category.find_by(id: @article.category_id)
      tags = @article.tags

      render json: {
        message: "get article successfully",
        article: @article,
        category_name: @category.name,
        tags: tags
      }, status: 200
    else
      render json: { error: "Article not found" }, status: 404
    end
  end

  def create
    @category = Category.find_by(name: article_params[:category_name])

    if @category.nil?
      @category = Category.create(name: article_params[:category_name])
    end

    @article = Article.new(
      title: article_params[:title],
      content: article_params[:content],
      category_id: @category.id,
      user_id: @user.id
    )

    if @article.save
      render json: {
        message: "Article create success",
        article: @article
      }, status: 201

      tag_names = article_params[:tags]  # ["a", "b", "c"]

      tag_names.each do |tag_name|
        tag = Tag.find_or_create_by(name: tag_name)
        @article.tags << tag unless @article.tags.include?(tag)
      end

    else
      render json: { error: "Unable to create article" }, status: 400
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article
      @category = Category.find_by(name: update_params[:category_name])
      if @category.nil?
        @category = Category.create(name: update_params[:category_name])
      end

      @article.tags.clear

      tag_names = article_params[:tags]  # ["a", "b", "c"]

      tag_names.each do |tag_name|
        tag = Tag.find_or_create_by(name: tag_name)
        @article.tags << tag unless @article.tags.include?(tag)
      end

      if @article.update(
        title: update_params[:title],
        content: update_params[:content],
        category_id: @category.id
      )
        render json: {
          message: "Article successfully updated",
          article: @article
        }, status: 200
      else
        render json: {
          message: "Article update failed"
        }, status: 400
      end
    else
      render json: { error: "Article not found" }, status: 404
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article
      @article.destroy
      render json: { message: "Article successfully deleted" }, status: 200
    else
      render json: { error: "Unable to delete article" }, status: 400
    end
  end

  def add_tags
    @article = Article.find_by(id: params[:article_id])

    if @article
      tag_names = params[:tags]  # ["a", "b", "c"]
      Rails.logger.info tag_names
      tag_names.each do |tag_name|
        tag = Tag.find_or_create_by(name: tag_name)
        Rails.logger.info "1111 #{tag_name}"
        @article.tags << tag unless @article.tags.include?(tag)
      end
      render json: { message: "Tags successfully added" }, status: 200
    else
      render json: { error: "Article not found" }, status: 404
    end
  end

  def show_tags
    @article = Article.find_by(id: params[:article_id])

    if @article
      tags = @article.tags
      render json: {
        message: "get article and tags successfully",
        tags: tags
      }, status: 200
    else
      render json: { error: "Article not found" }, status: 404
    end
  end

  def search
    @articles = Article.where("title LIKE ?", "%#{params[:keyword]}%")

    Rails.logger.info "Search Params: #{params.inspect}"
    render json: {
      message: "search articles successfully",
      articles: @articles
    }, status: 200
    if @articles.empty?
      render json: {
        message: "No articles found"
      }, status: 200 # not error
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :user_id, :category_name, tags: [])
  end

  def update_params
    params.require(:article).permit(:title, :content, :category_name, tags: [])
  end
end
