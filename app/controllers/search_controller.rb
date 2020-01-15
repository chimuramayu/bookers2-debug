class SearchController < ApplicationController
before_action :authenticate_user!

def search
	@search = params[:search]
	@model = params[:model]
	@match = params[:match]
	@results = detail(@search, @model, @match)
end

	def detail(search, model, match)
	if @model == "user"
		if match == "perfect_match"
			User.where("#{search}")
		elsif match == "partial_match"
			User.where("name LIKE?","%#{search}%")
		elsif match == "forward_match"
			User.where("name LIKE?","#{search}%")
		elsif match == "backward_match"
			User.where("name LIKE?","%#{search}")
		else
			User.all
		end
	elsif	@model == "book"
		if match == "perfect_match"
			Book.where("#{search}")
		elsif match == "partial_match"
			Book.where("title LIKE?","%#{search}%")
		elsif match == "forward_match"
			Book.where("title LIKE?","#{search}%")
		elsif match == "backward_match"
			Book.where("title LIKE?","%#{search}")
		else
			Book.all
		end
	end
end
end