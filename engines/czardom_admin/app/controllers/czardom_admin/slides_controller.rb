module CzardomAdmin
  class SlidesController < AdminController

    def index
      @slides = Slide.order(:position)
    end

    def new
      @slide = Slide.new
      @root_article = RootArticle.new(slide: @slide)
    end

    def edit
      @slide = Slide.find(params[:id])
      @root_article = RootArticle.new(slide: @slide) unless @slide.root_article
    end

    def create
      if slide_params[:use_url] == 'use_url'
        slide_params.delete(:root_article_attributes)
        slide_params.delete("root_article_attributes")
      end
      @slide = Slide.new(slide_params)
      
      if @slide.save!
      
        if slide_params[:image]
          render :crop
        else
          redirect_to slides_path
        end
      else
        render :new
      end
    end

    def update
      @slide = Slide.find(params[:id])
      if slide_params[:use_url] == 'use_url'
        slide_params.delete(:root_article_attributes)
        slide_params.delete("root_article_attributes")
      end
   
      if @slide.update_attributes(slide_params)
        
        if slide_params[:image]
          render :crop
        else
          redirect_to slides_path
        end
      else
        render :edit
      end
    end

    def destroy
      Slide.destroy(params[:id])
      redirect_to slides_path
    end

    def update_position
      feeds = Slide.find(params[:feed_ids].keys)

      Slide.transaction do
        feeds.each_with_index do |feed, i|
          feed.update_attributes(position: params[:feed_ids].fetch(feed.id.to_s, i))
        end
      end

      render json: feeds
    end

    private

    def slide_params
      params.require(:slide).permit(
        :image, :caption, :url, :use_url,
        :crop_x, :crop_y, :crop_w, :crop_h, 
        root_article_attributes: [:title, :id, :caption, :body, :media]
      )
    end

  end
end
