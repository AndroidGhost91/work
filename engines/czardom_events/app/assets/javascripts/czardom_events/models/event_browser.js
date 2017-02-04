var EventBrowser = function() {
  var self = this;

  self.reloadEvents = function() {
    self.loadEventsForDay();
    $('#calendar').fullCalendar('refetchEvents');
  }

  // Selected Filters
  self.currentDate = ko.observable();
  self.activeRegions = ko.observableArray();
  self.activeGroups = ko.observableArray();

  self.selectedDate = ko.computed(function() {
    return moment(self.currentDate()).format('MMMM DD, YYYY');
  });

  self.groups = ko.observableArray();

  self.events = ko.observableArray();

  self.currentDate.subscribe(function() {
    self.loadEventsForDay();
  });

  self.activeRegions.subscribe(self.reloadEvents);
  self.activeGroups.subscribe(self.reloadEvents);

  self.countEventsByDay = function(start, end, callback) {
    var options = {
      start: start.format('YYYY-MM-DD'),
      end: end.format('YYYY-MM-DD')
    };

    if( self.activeRegions().length > 0 ) {
      options['regions'] = self.activeRegions();
    }

    if( self.activeGroups().length > 0 ) {
      options['groups'] = self.activeGroups();
    }

    $.getJSON('/calendar/events/count_by_day.json', options, function(events) {
      callback(events);
    });
  }

  self.loadEventsForDay = function() {
    var options = {},
        date = self.currentDate();
    self.events.removeAll();

    if( date ) {
      options['date'] = date;
    }

    if( self.activeRegions().length > 0 ) {
      options['regions'] = self.activeRegions();
    }

    if( self.activeGroups().length > 0 ) {
      options['groups'] = self.activeGroups();
    }

    $.getJSON('/calendar/events.json', options, function(data) {
      _.each(data.events, function(calendar_event) {
        self.events.push(new Event(calendar_event));
      });
    });
  }
  
  // Selectable Map Regions
  self.regions = ko.observableArray();
  self.map = null;
  self.mapbox = null;
  self.mapFeatures = null;
  self.highlightMapCircle = {};

  self.mouseOverRegion = function() {
    if( this.active() ) { return; }

    self.highlightMapCircle[this.id] = L
      .circle(this.latLng(), milesToMeters(this.radius), { color: '#999' })
      .addTo(self.mapFeatures);

    self.mapbox.fitBounds( self.mapFeatures.getBounds(), { animate: false } );
  }

  self.mouseOutRegion = function() {
    if( this.active() ) { return; }

    self.mapFeatures.removeLayer(self.highlightMapCircle[this.id]);

    try {
      self.mapbox.fitBounds( self.mapFeatures.getBounds(), { animate: false } );
    } catch(e) {
    }
  }

  self.toggleActiveRegion = function() {
    this.toggleActive();

    if( this.active() ) {
      self.highlightMapCircle[this.id].setStyle({ color: '#806F69' });
      self.activeRegions.push(this.id);
    }else {
      self.highlightMapCircle[this.id].setStyle({ color: '#999' });
      self.activeRegions.remove(this.id);
    }
  }

  self.toggleActiveGroup = function() {
    this.toggleActive();

    if( this.active() ) {
      self.activeGroups.push(this.id);
    }else {
      self.activeGroups.remove(this.id);
    }
  }
}

