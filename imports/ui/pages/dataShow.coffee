{ Meteor } = require 'meteor/meteor'
{ Template } = require 'meteor/templating'

{ CollectedData } = require '/imports/api/links/collections.js'

require './dataShow.html.jade' # contains samsonDaxShowData template as well



Template.dataShow.onCreated () ->
  self = this
  self.autorun () ->
    experimentName = FlowRouter.getParam('_experimentName')
    self.subscribe('collectedData.forExperiment', experimentName)


Template.dataShow.helpers 
  allData : () -> 
    experimentName = FlowRouter.getParam('_experimentName')
    return CollectedData.find({experimentName})
  experimentName : () -> 
    FlowRouter.getParam('_experimentName')
  createdFormatted : () -> 
    return moment(@created).format("YYYY-MM-DD HH:mm")


Template.dataShowCSV.onCreated () ->
  self = this
  self.autorun () ->
    _id = FlowRouter.getParam('_id')
    self.subscribe('collectedData.one', _id)

Template.dataShowCSV.helpers 
  experimentName : () -> 
    FlowRouter.getParam('_experimentName')
  createdFormatted : () -> 
    return moment(@created).format("YYYY-MM-DD HH:mm")
  csvData : () ->
    _id = FlowRouter.getParam('_id')
    d = CollectedData.findOne({_id})
    if d?
      return d.csvData
    else
      return ""
 

Template.dataShowJSON.onCreated () ->
  self = this
  self.autorun () ->
    _id = FlowRouter.getParam('_id')
    self.subscribe('collectedData.one', _id)


Template.dataShowJSON.helpers 
  experimentName : () -> 
    FlowRouter.getParam('_experimentName')
  createdFormatted : () -> 
    return moment(@created).format("YYYY-MM-DD HH:mm")
  jsonData : () ->
    _id = FlowRouter.getParam('_id')
    d = CollectedData.findOne({_id})
    if d?
      return JSON.stringify(d.data,undefined,1)
    else
      return ""


   
    
Template.dataShowAllJSON.onCreated () ->
  self = this
  self.autorun () ->
    experimentName = FlowRouter.getParam('_experimentName')
    self.subscribe('collectedData.forExperiment', experimentName)
Template.dataShowAllJSON.helpers 
  experimentName : () -> 
    FlowRouter.getParam('_experimentName')
  allData : () -> 
    experimentName = FlowRouter.getParam('_experimentName')
    d = CollectedData.find({experimentName}).fetch()
    return JSON.stringify(d,undefined,1)
