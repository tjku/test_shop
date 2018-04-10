class ProductsController < ApplicationController
  def index
    @products = Product.match_all_query(params[:page])
    total_count = @products.response.hits.total

    @products = Kaminari.paginate_array(@products, total_count: total_count)
                        .page(params[:page])
                        .per(100)
  end
end
