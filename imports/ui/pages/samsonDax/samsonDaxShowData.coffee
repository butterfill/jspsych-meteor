import { Meteor } from 'meteor/meteor'
import { Template } from 'meteor/templating'

import { CollectedData } from '/imports/api/links/collections.js'

import './samsonDax01.html' # contains samsonDaxShowData template as well



Template.App_samsonDaxShowData.onCreated () ->
  Meteor.subscribe('collectedData.all')

Template.App_samsonDaxShowData.helpers 
  allData : () -> CollectedData.find()
  createdFormatted : () ->
    return moment(@created).format("YYYY-MM-DD HH:mm")
  