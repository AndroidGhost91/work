//= require knockout
//= require moment
//= require fullcalendar
//= require ./models/calendar_region
//= require ./models/calendar_group
//= require ./models/event_browser
//= require ./models/event

function milesToMeters(meters) {
  var km_to_miles = 0.62;
  return (meters * 1000) * km_to_miles;
}

function setUpCalendar() {

  $(document).ready(function() {

    L.mapbox.accessToken = 'pk.eyJ1IjoiY3phcmRvbSIsImEiOiJLN2dRd2ZVIn0.pElgu-Ws2Sg41nHOAN1N5A';

    var eventCalendar = new EventBrowser(),
        regionLocations = $('#region-map');

    $('#calendar').fullCalendar({
      height: 'auto',
      events: function(start, end, timezone, callback) {
        eventCalendar.countEventsByDay(start, end, callback);
      },
      header: {
        left: '',
        center: 'title',
        right: 'prev,next'
      },
      eventClick: function(calEvent, e, view) {
        eventCalendar.currentDate(calEvent.id);
        $(window).scrollTo('#events-title', 500);
      },
      dayClick: function(moment, e, view) {
        var date = moment.format('YYYY-MM-DD');
        eventCalendar.currentDate(date);
        $(window).scrollTo('#events-title', 500);

        $('.fc-day').removeClass('events-for-day');
        $(this).addClass('events-for-day');
      }
    });

    ko.applyBindings(eventCalendar, $('#event-browser').get(0));

    _.each($('#group-selection').data('groups'), function(group) {
      eventCalendar.groups.push(new CalendarGroup(group));
    });

    eventCalendar.loadEventsForDay();

    $('#search-regions')
      .webuiPopover({
        placement: 'right-bottom',
        title: 'Search by Location',
        content: regionLocations.html(),
        closeable: true,
        width: 800,
        template: '<div class="webui-popover">' +
                    '<div class="arrow"></div>' +
                    '<div class="webui-popover-inner">' +
                    '<a href="#" class="close"><i class="fa fa-times"></i></a>' +
                    '<h3 class="webui-popover-title"></h3>' +
                    '<div class="webui-popover-content"><i class="icon-refresh"></i> <p>&nbsp;</p></div>' +
                    '</div>' +
                    '</div>'
      })
      .on('shown.webui.popover', function() {
        var el = $(this),
            popover = el.data('plugin_webuiPopover').$target;
        
        eventCalendar.map = popover.find('#map').get(0);

        try {
          ko.applyBindings(eventCalendar, popover.get(0));
        } catch(e) {}

        if( eventCalendar.regions().length == 0 ) {
          $.getJSON('/calendar/regions.json', function(data) {
            _.each(data.regions, function(region) {
              eventCalendar.regions.push(new CalendarRegion(region));
            });
          });
        }

        if( eventCalendar.mapbox === null ) {
          eventCalendar.mapbox = L.mapbox.map(eventCalendar.map, 'czardom.k2oc4b4c')
            .fitBounds([
              [56.75272287205736, -36.73828124999999],
              [16.29905101458183, -142.20703125]
            ])

          eventCalendar.mapFeatures = L.mapbox.featureLayer().addTo(eventCalendar.mapbox)
        }
      });

      window.eventCalendar = eventCalendar;
  });
}

if( /^\/calendar\/?/.test(window.location.pathname) ) {
  setUpCalendar()
}
