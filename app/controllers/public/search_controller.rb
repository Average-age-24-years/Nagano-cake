class SearchController < ApplicationController
  def search
    @model = params["search"]["model"]
    @value = params["search"]["value"]
    @how = params["search"]["how"]
    @datas = search_for(@how, @model, @value)
  end
  
  private
  
  def model(model, value)
    if model == 'customer'
      Customer.where(last_name: value)
    elsif mode == 'book'
        Product.where(product: value)
    end
  end
  
  def forward(model, value)
    if model == 'Customer'
      Customer.where("last_name LIKE ?", "#{value}%")
    elsif model == 'product'
      Product.where("name LIKE ?", "#{value}%")
    end
  end
  
  def backward(model, value)
    if model == 'customer'
      Customer.where("last_name LIKE ?", "%#{value}")
    elsif model == 'product'
        Product.where("name LIKE ?", "%#{value}")
    end
  end
  
  def partical(model, value)
    if model == 'customer'
      Customer.where('last_name LIKE ?', "%#{value}%")
    elsif model == 'product'
      Product.where("name LIKE ?", "%#{value}%")
    end
  end
  
  def search_for(how, model, value)
    case how
    when 'match'
      match(model, value)
    when 'forward'
      forward(model, value)
    when 'backward'
      backward(model, value)
    when 'partical'
      partical(model, value)
    end
  end
end
