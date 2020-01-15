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
		if @search.blank?
			User.all
		else
			if match == "perfect_match"
				User.where(name: search)
			elsif match == "partial_match"
				User.where("name LIKE?", "%#{search}%")
			elsif match == "forward_match"
				User.where("name LIKE?", "#{search}%")
			elsif match == "backward_match"
				User.where("name LIKE?", "%#{search}")
			end
		end
	elsif	@model == "book"
		if @search.blank?
			Book.all
		else
			if match == "perfect_match"
				Book.where(title: search).or(Book.where(body: search))
			elsif match == "partial_match"
				Book.where("title LIKE? OR body LIKE?", "%#{search}%", "%#{search}%")
			elsif match == "forward_match"
				Book.where("title LIKE? OR body LIKE?", "#{search}%", "#{search}%")
			elsif match == "backward_match"
				Book.where("title LIKE? OR body LIKE?", "%#{search}", "%#{search}")
			end
		end
	end
end
end