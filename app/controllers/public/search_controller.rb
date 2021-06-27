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
			@records = Product.search_for(record, @method).page(params[:page]).reverse_order
	end
end
