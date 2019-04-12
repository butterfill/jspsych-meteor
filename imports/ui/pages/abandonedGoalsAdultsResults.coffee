require './abandonedGoalsAdultsResults.html.jade'
{ CollectedData } = require '/imports/api/links/collections.js'


getGoalNongoal = (v) ->
  row = []
  for i in ['goal', 'nongoal']
    row.push "#{i}::"
    row.push v[i].num
    row.push v[i].numCorrect
    row.push v[i].totalRT
    row.push v[i].rtCorrect
  return row

getRowStart = (o) ->
  [
    moment(o.created).format("YYYY-MM-DD HH:mm")
    o.participantId
    "[#{o.expConditionOrder?.join('|')}]"
    "[#{o.storyIdOrder?.join('|')}]"
    o.experimenterId
    o.familiarisationStoryType
  ]

getRow = (o) ->
  row = getRowStart(o)
  for type in ['familiarisation', 'abandoned', 'incomplete', 'complete']
    row.push "#{type}::"
    for k, v of o.summary[type]
      row.push "story-#{k}"
      row = row.concat( getGoalNongoal(v) )
  return row

getRowByStory = (o) ->
  console.log o.summaryByStory
  row = getRowStart(o)
  for i in [0,1,2,3,4,5]
    continue unless o.summaryByStory[i]?
    row.push "story#{i}::"
    row.push o.summaryByStory[i].condition
    row = row.concat( getGoalNongoal(o.summaryByStory[i]) )
  return row

 
HEADERS = [
  'created'
  'participantId'
  'expConditionOrder'
  'storyIdOrder'
  'experimenterId'
  'familiarisationStoryType'
  'familiarisation' #<-- abandoned
  'storyId-familiarisation'
  'goal-familiarisation'
  'numAnswers-familiarisation'
  'numCorrect-familiarisation'
  'totalRT-familiarisation'
  'rtCorrect-familiarisation'
  'nongoal-familiarisation'
  'numAnswers-familiarisation'
  'numCorrect-familiarisation'
  'totalRT-familiarisation'
  'rtCorrect-familiarisation'
  'abandoned' #<-- abandoned
  'storyId-abandoned1'
  'goal-abandoned1'
  'numAnswers-abandoned1'
  'numCorrect-abandoned1'
  'totalRT-abandoned1'
  'rtCorrect-abandoned1'
  'nongoal-abandoned1'
  'numAnswers-abandoned1'
  'numCorrect-abandoned1'
  'totalRT-abandoned1'
  'rtCorrect-abandoned1'
  'storyId-abandoned2'
  'goal-abandoned2'
  'numAnswers-abandoned2'
  'numCorrect-abandoned2'
  'totalRT-abandoned2'
  'rtCorrect-abandoned2'
  'nongoal-abandoned2'
  'numAnswers-abandoned2'
  'numCorrect-abandoned2'
  'totalRT-abandoned2'
  'rtCorrect-abandoned2'
  'incomplete' #<-- incomplete
  'storyId-incomplete1'
  'goal-incomplete1'
  'numAnswers-incomplete1'
  'numCorrect-incomplete1'
  'totalRT-incomplete1'
  'rtCorrect-incomplete1'
  'nongoal-incomplete1'
  'numAnswers-incomplete1'
  'numCorrect-incomplete1'
  'totalRT-incomplete1'
  'rtCorrect-incomplete1'
  'storyId-incomplete2'
  'goal-incomplete2'
  'numAnswers-incomplete2'
  'numCorrect-incomplete2'
  'totalRT-incomplete2'
  'rtCorrect-incomplete2'
  'nongoal-incomplete2'
  'numAnswers-incomplete2'
  'numCorrect-incomplete2'
  'totalRT-incomplete2'
  'rtCorrect-incomplete2'
  'complete'   #<-- complete
  'storyId-complete1'
  'goal-complete1'
  'numAnswers-complete1'
  'numCorrect-complete1'
  'totalRT-complete1'
  'rtCorrect-complete1'
  'nongoal-complete1'
  'numAnswers-complete1'
  'numCorrect-complete1'
  'totalRT-complete1'
  'rtCorrect-complete1'
  'storyId-complete2'
  'goal-complete2'
  'numAnswers-complete2'
  'numCorrect-complete2'
  'totalRT-complete2'
  'rtCorrect-complete2'
  'nongoal-complete2'
  'numAnswers-complete2'
  'numCorrect-complete2'
  'totalRT-complete2'
  'rtCorrect-complete2'
]

HEADERS_BY_STORY = [
  'created'
  'participantId'
  'expConditionOrder'
  'storyIdOrder'
  'experimenterId'
  'familiarisationStoryType'
]
for i in [0,1,2,3,4,5]
  hdrs = [
    "story#{i}"
    "condition-story#{i}"
    "goal-story#{i}"
    "numAnswers-story#{i}"
    "numCorrect-story#{i}"
    "totalRT-story#{i}"
    "rtCorrect-story#{i}"
    "nongoal-story#{i}"
    "numAnswers-story#{i}"
    "numCorrect-story#{i}"
    "totalRT-story#{i}"
    "rtCorrect-story#{i}"
  ]
  for x in hdrs
    HEADERS_BY_STORY.push(x )



process = (data) ->
  return [] unless data?
  res = []
  resByStory = {}
  # console.log data
  for subjectData in data
    participantId = subjectData.participantId
    line = {}
    for key in ['created','participantId', 'expConditionOrder', 'storyIdOrder', 'experimenterId', 'familiarisationStoryType']
      line[key] = subjectData?[key]
    main = {}
    byStory = {}
    for trial in subjectData.data
      continue unless trial.trial_type is 'html-keyboard-response'
      continue unless trial.sentence?.cat?
      continue unless trial.condition?
      condition = trial.condition.split('-')[0]
      main[condition] ?= {}
      o = main[condition]
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
      byStory[trial.storyId] ?= {condition}
      byStory[trial.storyId][cat] = o[trial.storyId][cat]
    line.summary = main
    line.summaryByStory = byStory
    res.push(line)
  console.log res
  forCsv = [HEADERS]
  for line in res
    forCsv.push( getRow(line) )
  forCsvByStory = [HEADERS_BY_STORY]
  for line in res
    forCsvByStory.push( getRowByStory(line) )
  console.log forCsvByStory
  return {forCsv, forCsvByStory}


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
    return process(data).forCsv
  processedDataByStory : () ->
    experimentName = FlowRouter.getParam('_experimentName')
    data = CollectedData.find({experimentName}).fetch()
    return process(data).forCsvByStory
  createdFormatted : () -> 
    return moment(@created).format("YYYY-MM-DD HH:mm")
