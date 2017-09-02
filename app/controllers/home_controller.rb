class HomeController < ApplicationController
	protect_from_forgery with: :null_session

	def send_email
		new_contact = Person.new
		new_contact.name = params[:name]
		new_contact.email = params[:email]
		new_contact.message = params[:message]
		UserMailer.welcome_email(new_contact).deliver
		respond_to do |format|
	      format.json { render json: {"message": "curves for drawing destroyed"}  }
	    end
	end

	# private
		# def home_params
	 #      params.require(:person).permit(:name, :email, :message)
	 #    end
end
