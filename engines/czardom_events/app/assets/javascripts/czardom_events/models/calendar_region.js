var CalendarRegion = function(region) {
  var self = this;

  self.active = ko.observable(false);
  self.id = region.id;
  self.title = region.title;
  self.latitude = region.latitude;
  self.longitude = region.longitude;
  self.radius = region.radius;

  self.latLng = function() {
    return [self.latitude, self.longitude];
  }

  self.activeClass = ko.computed(function() {
    return self.active() ? 'active' : '';
  });

  self.activeIcon = ko.computed(function() {
    return self.active() ? 'fa-check-square' : 'fa-square-o';
  });
  
  self.toggleActive = function() {
    self.active(!self.active());
  }
}
