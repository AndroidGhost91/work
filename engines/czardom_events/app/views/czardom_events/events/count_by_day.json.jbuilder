json.array! @events do |date, count|
  json.id date
  json.title pluralize(count, 'event')
  json.allDay true
  json.start date
end
