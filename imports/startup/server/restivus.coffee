{ Restivus } = require 'meteor/nimble:restivus'

{ Meteor } = require 'meteor/meteor'
{ CollectedData, Experiments } = require '/imports/api/links/collections.js'

Api = new Restivus({prettyJson : true})

Api.addCollection(Experiments, {authRequired:false})

Api.addRoute 'insertData/:experimentName', {authRequired:false},
  post :
    authRequired:false
    action : () ->
      console.log @bodyParams
      toInsert = @bodyParams
      toInsert.experimentName = @urlParams.experimentName
      return Meteor.call('data.insert', toInsert)