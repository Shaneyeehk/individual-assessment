class StaticController < ApplicationController

	def home
		response = RestClient.get("https://api.chucknorris.io/jokes/random")
		result = JSON.parse(response.body)
		@joke = result["value"]
	end

end
