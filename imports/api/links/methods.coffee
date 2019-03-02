{ Meteor } = require 'meteor/meteor'
{ check } = require 'meteor/check'
{ CollectedData, PersonalInfo, Experiments } = require '/imports/api/links/collections.js'

Meteor.methods 'data.insert': (data) ->
  # if !Meteor.userId()
  #   throw new (Meteor.Error)('not-authorized')
  if !data.experimentName or data.experimentName is ''
    throw new (Meteor.Error)('experimentName must be specified when calling data.insert method')
  data.created = new Date()
  res = CollectedData.insert(data)
  e = Experiments.findOne({experimentName: data.experimentName})
  if e?
    Experiments.update(e._id, $set:{
      lastUpdated: new Date()
    })
    e.lastUpdated = new Date()
  unless e?
    console.log "data.experimentName #{data.experimentName}"
    Experiments.insert
      experimentName: data.experimentName
      created: new Date()
      lastUpdated: new Date()
  return res

Meteor.methods 'personalInfo.insert': (data) ->
  if !data.experimentName or data.experimentName is ''
    throw new (Meteor.Error)('experimentName must be specified when calling data.insert method')
  data.created = new Date()
  res = PersonalInfo.insert(data)
  return res
