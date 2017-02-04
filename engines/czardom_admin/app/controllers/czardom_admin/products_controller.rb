module CzardomAdmin
  class ProductsController < AdminController
    load_and_authorize_resource class: 'Product'

    def index
      @products.order!('created_at desc')
      respond_with @products
    end

    def show
      respond_with @product
    end

    def new
      respond_with @product
    end

    def create
      @product.save
      respond_with @product
    end

    def edit
      respond_with @product
    end

    def update
      @product.update_attributes(product_params)
      respond_with @product
    end

    private

    def product_params
      params.require(:product).permit(:name, :permalink, :price, :redirect_path)
    end

  end
end
