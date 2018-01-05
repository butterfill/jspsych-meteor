// All links-related publications

import { Meteor } from 'meteor/meteor';
import { CollectedData, Experiments } from '/imports/api/links/collections.js'


Meteor.publish('collectedData.all', function () {
  return CollectedData.find();
});

Meteor.publish('experiments.all', function(){
  return Experiments.find( {}, {
    sort:{lastUpdated:-1}
  });
});

Meteor.publish('collectedData.forExperiment', function(experimentName){
  return CollectedData.find( {experimentName}, {
    sort:{created:-1}
  });
});

Meteor.publish('collectedData.one', function(_id){
  return CollectedData.find( {_id} );
});
