require './hello.html'

{ CollectedData, Experiments } = require '/imports/api/links/collections.js'

Template.hello.onCreated () -> 
  # counter starts at 0
  this.counter = new ReactiveVar(0);
  Meteor.subscribe('experiments.all')


Template.hello.helpers
  counter : () ->
    return Template.instance().counter.get();
  experiments : () ->
    return Experiments.find();
  lastUpdatedFormatted : () ->
    return '' unless @lastUpdated?
    return moment(@lastUpdated).format("YYYY-MM-DD HH:mm");
  createdFormatted : () ->
    return moment(@created).format("YYYY-MM-DD HH:mm");

Template.hello.events
  'click button'  : (event, instance) -> 
    # increment the counter when button is clicked
    instance.counter.set(instance.counter.get() + 1);
