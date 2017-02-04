module CzardomAdmin
  class SalesController < AdminController
    load_and_authorize_resource class: 'Payola::Sale'

    def index
      @sales = @sales.order('created_at desc')

      @weekly_overview = ActiveRecord::Base.connection.exec_query(%q{
select
	extract(year from created_at) sale_year,
	extract(week from created_at) sale_week,
  count(*) sales,
	sum(amount) / 100 gross
from
	payola_sales
where
	created_at >= now() - interval '1 year'
group by
	sale_year,
	sale_week
order by
	sale_year asc,
	sale_week asc;
})

      respond_with @sales
    end

    def show
      @sale = Payola::Sale.find(params[:id])
      respond_with @sale
    end

  end
end
