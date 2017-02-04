module CzardomAdmin
  class RootArticlesController < AdminController
    # load_and_authorize_resource

    def index
      @title = 'Root Articles'
      
      @root_articles = RootArticle.all

      respond_to do |f|
        f.html
      end
    end

    def show
      @root_article = RootArticle.find(params[:id])
    end

    def new
      @root_article = if params[:slide_id] && RootArticle.where(slide_id: params[:slide_id]).exists?
                        RootArticle.where(slide_id: params[:slide_id]).first
                      else
                        RootArticle.new
                      end
    end

    def create
      @root_article = RootArticle.create(root_article_params)
      respond_with @root_article
    end

    def edit
      @root_article = if params[:slide_id] && RootArticle.where(slide_id: params[:slide_id]).exists?
                        RootArticle.where(slide_id: params[:slide_id]).first
                      elsif params[:id]
                        RootArticle.where(id: params[:id]).first  
                      else
                        RootArticle.new
                      end
    end

    def update
      @root_article = RootArticle.find(params[:id])
      @root_article.assign_attributes(root_article_params)
      @root_article.save(validate: false)
      respond_with @root_article
    end

    private

    def root_article_params
      params.require(:root_article).permit(
        :title, :media, :body, :slide_id
      )
    end
  end
end
