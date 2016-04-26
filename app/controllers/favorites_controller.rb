class FavoritesController < ApplicationController


	def add 
		first_user = User.find(params[:current_user])
		second_user = User.find(params[:user])
		@favorite = Favorite.new(:first_id => first_user.id , :second_id => second_user.id) 
		@favorite.save
		redirect_to controller: "users", action: "index"
	end

	def delete 

	end

end