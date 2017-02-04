module CzardomAdmin
  class PagesController < AdminController
    
    def dashboard
      @filtered_users = User.where('email not like ?', '%fb-user-id.com')

      @count_users = @filtered_users.count
      @count_sales = Payola::Sale.count

      count_objects('users', @filtered_users)
      count_objects('sales', Payola::Sale.where(state: 'finished'))

      @amount_in_sales = Payola::Sale
        .where(state: 'finished')
        .where('extract(year from created_at) = extract(year from now())')
        .where("extract(week from created_at) = extract(week from now())")
        .sum(:amount) / 100.0

      @donated_user_count = Payola::Sale.select('distinct owner_id').count

      @top_groups = GroupUser
        .select('groups.name as name, count(user_id) as count_users')
        .joins(:group)
        .group('groups.name')
        .order('count_users desc')
        .limit(10)

      @top_users = UserFollower
        .select("users.first_name || ' ' || users.last_name full_name, count(user_id) as count_followers")
        .joins('left join users on (users.id = following_id)')
        .group('full_name')
        .order('count_followers desc, full_name')
        .limit(10)

      @sales_and_sign_ups = ActiveRecord::Base.connection.exec_query(%q{
with sales as (
	select
		date(created_at) created_on,
		count(*) count_sales
	from
		payola_sales
	group by
		created_on
)

select
	date(created_at) as signed_up_on,
	count(*) as new_accounts,
	sales.count_sales
from
	users
inner join
	sales on (sales.created_on = date(users.created_at))
where
	sign_in_count > 0 and
  created_at >= now() - interval '2 weeks'
group by
	signed_up_on,
	sales.count_sales
order by
	signed_up_on desc
      })
    end

    private

    def count_objects(key, relation)
      instance_variable_set("@#{key}_today", relation
        .where('extract(year from created_at) = extract(year from now())')
        .where('extract(doy from created_at) = extract(doy from now())').count)

      instance_variable_set("@#{key}_this_week", relation
        .where('extract(year from created_at) = extract(year from now())')
        .where("extract(week from created_at) = extract(week from now())").count)

      instance_variable_set("@#{key}_last_week", relation
        .where('extract(year from created_at) = extract(year from now())')
        .where("extract(week from created_at) = extract(week from now() - interval '1 week')").count)
    end

  end
end
