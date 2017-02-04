Given(/^I have created several groups$/) do
  @groups = {}
  %w(sports music film dance money).each do |group|
    @groups[group] = create(:group, name: group.titleize, sticky: true)
  end

  %w(onions roadkill windows).each do |group|
    create(:group, name: group.titleize, sticky: true)
  end
end

