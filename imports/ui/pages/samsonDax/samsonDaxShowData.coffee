{ Meteor } = require 'meteor/meteor'
{ Template } = require 'meteor/templating'

{ CollectedData } = require '/imports/api/links/collections.js'

require './samsonDax01.html' # contains samsonDaxShowData template as well



Template.App_samsonDaxShowData.onCreated () ->
  Meteor.subscribe('collectedData.all')

Template.App_samsonDaxShowData.helpers 
  allData : () -> CollectedData.find()
  createdFormatted : () ->
    return moment(@created).format("YYYY-MM-DD HH:mm")
  