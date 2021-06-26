class Public::SearchController < ApplicationController
 	def search
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
           unless @content.blank?
           if @content.match(/[一-龠々]/)
              record = @content.to_kanhira.to_roman
           elsif @content.is_hira? || @content.is_kana?
              record = @content.to_roman
           else
              record = @content
           end
           end		
		if @model == 'genre'
			@records = Genre.search_for(record, @method).page(params[:page]).reverse_order
           	@records = Product.search_for(record, @method).page(params[:page]).reverse_order
			@active_products = Product.where(is_active: true)
		else
			@records = Product.search_for(record, @method).page(params[:page]).reverse_order
			@active_products = Product.where(is_active: true)
		end
	end
end
