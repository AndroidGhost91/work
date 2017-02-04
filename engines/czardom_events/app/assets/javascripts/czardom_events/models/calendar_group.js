var CalendarGroup = function(group) {
  var self = this;

  self.active = ko.observable(false);

  self.id = group.id;
  self.name = group.name;
  self.image = group.image.tiny.url;

  self.toggleActive = function() {
    self.active(!self.active());
  }
}
