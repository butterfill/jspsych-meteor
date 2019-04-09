require './abandonedGoalsAdultsResults.html.jade'
{ CollectedData } = require '/imports/api/links/collections.js'


getGoalNongoal = (o) ->
  row = []
  for k, v of o
    row.push "story-#{k}"
    for i in ['goal', 'nongoal']
      row.push "#{i}::"
      row.push v[i].num
      row.push v[i].numCorrect
      row.push v[i].totalRT
      row.push v[i].rtCorrect
  return row

getRow = (o) ->
  row = [
    moment(o.created).format("YYYY-MM-DD HH:mm")
    o.participantId
    "[#{o.expConditionOrder?.join(',')}]"
    JSON.toString o.storyIdOrder
    o.experimenterId
  ]
  for type in ['abandoned', 'incomplete', 'interrupted']
    row.push "#{type}::"
    for x in getGoalNongoal(o.summary[type])
      row.push(x)
  return row
  

process = (data) ->
  return [] unless data?
  res = []
  # console.log data
  for subjectData in data
    line = {}
    for key in ['created','participantId', 'expConditionOrder', 'storyIdOrder', 'experimenterId']
      line[key] = subjectData?[key]
    main = {}
    for trial in subjectData.data
      continue unless trial.trial_type is 'html-keyboard-response'
      continue unless trial.sentence?.cat?
      main[trial.condition] ?= {}
      o = main[trial.condition]
      o[trial.storyId] ?= {}
      cat = 'nongoal'
      cat = 'goal' if trial.category is 'goal'
      continue unless trial.storyId?
      o[trial.storyId][cat] ?= {}
      o[trial.storyId][cat].num ?= 0
      o[trial.storyId][cat].num += 1
      o[trial.storyId][cat].numCorrect ?= 0
      o[trial.storyId][cat].numCorrect += 1 if trial.is_correct
      o[trial.storyId][cat].totalRT ?= 0
      o[trial.storyId][cat].totalRT += trial.rt
      o[trial.storyId][cat].rtCorrect ?= 0
      o[trial.storyId][cat].rtCorrect += trial.rt if trial.is_correct
    line.summary = main
    res.push(line)
  console.log res
  forCsv = []
  for line in res
    forCsv.push( getRow(line) )
  console.log forCsv
  return forCsv


t = Template.App_abandonedGoalsAdultsResults

t.onCreated () ->
  self = this
  self.autorun () ->
    experimentName = FlowRouter.getParam('_experimentName')
    self.subscribe('collectedData.forExperiment', experimentName)

t.helpers 
  allData : () -> 
    experimentName = FlowRouter.getParam('_experimentName')
    return CollectedData.find({experimentName})
  experimentName : () -> 
    FlowRouter.getParam('_experimentName')
  processedData : () ->
    experimentName = FlowRouter.getParam('_experimentName')
    data = CollectedData.find({experimentName}).fetch()
    return process(data)
  createdFormatted : () -> 
    return moment(@created).format("YYYY-MM-DD HH:mm")
