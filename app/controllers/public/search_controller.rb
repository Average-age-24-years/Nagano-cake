class Public::SearchController < ApplicationController
 	def search
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'genre'
			@records = Genre.search_for(@content, @method)
			@record = Product.search_for(@content, @method)
			@active_products = Product.where(is_active: true)
		else
			@records = Product.search_for(@content, @method)
		end
		#@genres = Genre.all
	end
end
