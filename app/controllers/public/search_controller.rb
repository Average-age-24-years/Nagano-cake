class Public::SearchController < ApplicationController
 	def search
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'genre'
			@records = Product.search_for(@content, @method).page(params[:page]).reverse_order
			@active_products = Product.where(is_active: true)
		else
			@records = Product.search_for(@content, @method).page(params[:page]).reverse_order
			@active_products = Product.where(is_active: true)
		end
	end
end
