//= require knockout

function UserSegment(segment) {
  var self = this;
  var children = segment.children || [];

  self.id = segment.id;
  self.name = segment.name;

  self.hasChildren = children.length > 0;
  self.children = []
  
  if( self.hasChildren ) {
    self.children = children.map(function(child) {
      return new UserSegment(child);
    });
  }
}

function UserSegmentsView(segments) {
  var self = this,
      segmentChildren = {};

  self.primarySegment = ko.observable();
  self.secondarySegment = ko.observable();

  self.segments = segments.map(function(segment) {
    segment = new UserSegment(segment)

    if( segment.hasChildren ) {
      segmentChildren[segment.id] = segment.children;
    }

    return segment
  });

  self.secondarySegments = ko.computed(function() {
    return self.primarySegment() ? segmentChildren[self.primarySegment()] : null;
  });
}
