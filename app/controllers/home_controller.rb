require 'net/https'
require 'json'

class HomeController < ApplicationController
	protect_from_forgery with: :null_session

	def send_email


		url_string = 'https://www.google.com/recaptcha/api/siteverify?secret=6LcaYy8UAAAAAJJRx7IdD30mf0rml4B2Q9uxHSWM&response='
		g_response = params[:g_response]
		url_string = url_string + g_response
		puts url_string

		uri = URI.parse(url_string)
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE

		request = Net::HTTP::Get.new(uri.request_uri)

		response = http.request(request)
		puts JSON.parse(response.body)["success"]
		resp = JSON.parse(response.body)["success"]
		if resp == true 
			new_contact = Person.new
			new_contact.name = params[:name]
			new_contact.email = params[:email]
			new_contact.message = params[:message]
			UserMailer.welcome_email(new_contact).deliver
		end
		respond_to do |format|
			if resp
	      		format.json { render json: {"message": "Email was successfully sent"}  }
	      	else
	      		format.json { render json: {"message": "Email did not send. Please refresh the page are try again"}  }
	      	end
	    end
	end

	# private
		# def home_params
	 #      params.require(:person).permit(:name, :email, :message)
	 #    end
end
