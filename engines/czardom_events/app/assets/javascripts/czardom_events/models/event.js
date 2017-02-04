var Event = function(calendar_event) {
  var self = this;

  self.id = calendar_event.id;
  self.title = calendar_event.title;
  self.description = calendar_event.description;
  self.description_truncated = $(calendar_event.description_truncated).text();
  self.start_at = calendar_event.start_at;
  self.end_at = calendar_event.end_at;
  self.url = calendar_event.url;
  self.users_going = calendar_event.users_going;
  self.status = calendar_event.status;

  self.start_date = moment(self.start_at).format('ddd MMM D');
  self.start_time = moment(self.start_at).format('h:mm a');
}
