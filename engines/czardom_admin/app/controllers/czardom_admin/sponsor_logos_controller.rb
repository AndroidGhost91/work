module CzardomAdmin
  class SponsorLogosController < AdminController

    def index
      @title = 'Sponsors'
      
      @sponsor_logos = SponsorLogo.all

      respond_to do |f|
        f.html
      end
    end
    
    def show
      @sponsor_logo = SponsorLogo.find(params[:id])
    end

    def new
        @sponsor_logo = SponsorLogo.new
    end
    
    def create
      @sponsor_logo = SponsorLogo.create(sponsor_logo_params)
      redirect_to sponsor_logos_path
    end

    def edit
      @sponsor_logo = SponsorLogo.find(params[:id])
    end
    
    def update
      @sponsor_logo = SponsorLogo.find(params[:id])
      @sponsor_logo.assign_attributes(sponsor_logo_params)
      @sponsor_logo.save(validate: false)
      respond_with @sponsor_logo
    end
    
    def destroy
      SponsorLogo.destroy(params[:id])
      redirect_to sponsor_logos_path
    end
  
    def add_group_sponsor
      group = Group.friendly.find(params[:id])
      sponsor_logo = SponsorLogo.find params[:sponsor_logo_id].to_i
      
      if group.sponsor_logos.include? sponsor_logo 
        group.sponsor_logos.delete(sponsor_logo)
      else
        group.sponsor_logos << sponsor_logo
      end
    end
    
    private
    
    def sponsor_logo_params
      if params[:sponsor_logo][:default_status]
        params[:sponsor_logo][:default_status] = params[:sponsor_logo][:default_status].to_i
      end
      params.require(:sponsor_logo).permit(
        :name, :path, :image, :default_status, group_ids: []
      )
    end
  end
end
