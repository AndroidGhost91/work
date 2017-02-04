class HooksController < ApplicationController
    def fb_created_callback
    # If the body contains the survey_name parameter...
    # if params[:survery_name].present?
    #   # Create a new Survey object based on the received parameters...
    #   survey = Survey.new(:name => params[:survey_name]
    #   survey.url = params[:survey_url]
    #   survey.creator_email = params[:survey_creator_email]
    #   survey.save!
    # end
    
    # The webhook doesn't require a response but let's make sure
    # we don't send anything
    if request.post?
    #handle posts
       logger.info("Post Signal.")
       p params
      # render :nothing => true
    else
      #handle gets
      # respond_to do |format|
      #   msg = { :status => "ok", :message => "Success!", :html => "<b>...</b>",:challenge =>"aaaa" }
      #   format.json  { render :json => msg } # don't do msg.to_json
      # end
      # params[:hub.challenge]　hub.verify_token 
      # mode = params[:mode]
      # p "mode--------" , mode
      # render status: 200,json:{"a" => 300}
      # if params[:mode].present?
          
      #       logger.info("ok0000000")
      #           render :json => {"aa" => "Bb"};
      # end
  
      if((params[:"hub.mode"] == "subscribe") && (params[:"hub.verify_token"] == "czardom"))
        render plain: params[:"hub.challenge"]
      #     # render  status: 300
      #   # render :json => {"aa" => "Bb"};
      #       # head :ok, content_type: "text/html"
      else
        
        head :ok, content_type: "text/html"
      end
        # render status: 200,json:{"a" => 300}
    end

   
 
  end
end
