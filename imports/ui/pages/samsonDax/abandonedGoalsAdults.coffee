{ Meteor } = require 'meteor/meteor'
{ Template } = require 'meteor/templating'


require './abandonedGoalsAdults.html'
{jsPsych} = require '/imports/startup/client/jspsych-5.0.3/jspsych.js'
require '/imports/startup/client/jspsych-5.0.3/plugins/jspsych-text.js'
require '/imports/startup/client/jspsych-5.0.3/plugins/jspsych-single-stim.js'
require '/imports/startup/client/jspsych-5.0.3/plugins/jspsych-instructions.js'

require '/imports/startup/client/jspsych-5.0.3/css/jspsych.css'

uuidv4 = require('uuid/v4')

timeline = []

TESTING = true

createInstructions = (inst) ->
  return {
    type : 'instructions'
    show_clickable_nav: true
    key_forward : 32   # space bar
    pages : inst
    timing_post_trial: 0
  }
  
    
timeline.push createInstructions([
  """
    <p>Welcome to the experiment. Press the space bar to advance to the next slide.</p>
  """
  """
    <p>Before we start, here is some practice. </p>
    <p>On the next screen, you will see a sentence to read.</p>
    <p>If the sentence is true, you should press ‘b’ (for TRUE). </p>
    <p>If the sentence is false, you should press ‘n’ (for FALSE). </p>
    <p>Press the space bar to walk through this process. </p>
  """
])


# --------------
# trainingBlock1 

createQuestions = (sentences) ->
  if TESTING
    timing_post_trial = 0
  else
    timing_post_trial = undefined
  return {
    type : 'single-stim'
    is_html : true
    timeline : ({stimulus:"<p>Question:</p><p style='margin-top:200px; margin-left:25px; font-size: 18pt'>#{sentence}</p>"} for sentence in sentences)
    choices : ['B', 'N']
    # prompt : '<p>Is this sentence true or false? Press ‘b’ for TRUE or ‘n’ for FALSE.</p>'
    timing_post_trial : timing_post_trial
  }
  
timeline.push createQuestions([
  'Snow is white.'
  'Touching fire can burn you.'
  'Snow is black.'
  'Inhaling cigarette smoke is bad for young children.'
])


timeline.push createInstructions([
  """
    <p>That’s the end of the practice. Now for the experiment. Press the space bar to advance to the next slide.</p>
  """
  """
    <p>Please read the following story carefully.  At some point you may be interrupted and asked to answer a question about it.</p>
  """
])



# --------------
# story1 


createLinesOfStory = (sentences) ->
  return {
    type : 'single-stim'
    is_html : true
    timeline :  ({stimulus:"<p style='font-size: 18pt'>#{s}</p>"} for s in sentences)
    choices : [' ']
    prompt : '<p>Press the space bar to continue.</p>'
    timing_post_trial: 0
  }

# narrative 1, complete goal
story11a = [
  'Betty had just woken up.'
  'She decided to bake a cake.'
  'She put on an apron.'
  'She got milk out of the fridge.'
  'But then she saw that it was time to go to work.'
  'She had an important meeting that morning.'
  'She finished making the cake quickly.'
  'She got straight in her car.'
  'She drove straight to work.'
  'She arrived and went straight to her morning meeting.'
]
story11b = [
  'At the meeting, Betty’s boss asked her to present her latest findings.'
  'She was nervous, but presented the confidently.'
  'Her presentation was well received.'
  'After the meeting, the boss offered Betty a promotion.'
]
questions1 = [
  'Did the story involve a cake.'
  'Did the story involve Zortan.'
  'Did the story involve baking.'
  'Did the story involve a car.'
  'Did the story involve a meeting.'
  'Did the story involve coffee.'
  'Did the story involve milk.'
  'Did the story involve a bus.'
]

# narrative 1, incomplete
story12a = [
  'Betty had just woken up.'
  'She decided to bake a cake.'
  'She put on an apron.'
  'She got milk out of the fridge.'
  'But then she saw that it was time to go to work.'
  'She had an important meeting that morning.'
  'She decided that she would have to find time for the cake later'
  'She got straight in her car.'
  'She drove straight to work.'
  'She arrived and went straight to her morning meeting.'
]
story12b = [
  'At the meeting, Betty’s boss asked her to present her latest findings.'
  'She was nervous, but presented the confidently.'
  'Her presentation was well received.'
  'After the meeting, the boss offered Betty a promotion.'
]

# narrative 1, abandoned
story13a = [
  'Betty had just woken up.'
  'She decided to bake a cake.'
  'She put on an apron.'
  'She got milk out of the fridge.'
  'But then she saw that it was time to go to work.'
  'She had an important meeting that morning.'
  'She decided that she would not make the cake after all'
  'She got straight in her car.'
  'She drove straight to work.'
  'She arrived and went straight to her morning meeting.'
]
story13b = [
  'At the meeting, Betty’s boss asked her to present her latest findings.'
  'She was nervous, but presented the confidently.'
  'Her presentation was well received.'
  'After the meeting, the boss offered Betty a promotion.'
]

# TODO:
# from the three naratives, pick one incomplete, one abandoned and one complete
# randomise order in which the stories are presented.

timeline.push createLinesOfStory( story11a )
timeline.push createQuestions( questions1 )
timeline.push createLinesOfStory( story11b )



imagesToPreload = [
]


Template.App_abandonedGoalsAdults.events
  'click #init-jspsych' : (event, instance) ->
    $('#init-jspsych').hide()
    $('#please-wait').show()
    # console.log "imagesToPreload ..."
    # console.log imagesToPreload
    updateProgress = (numLoaded) ->
      console.log "loaded #{numLoaded} images"
    startExp = () -> 
      participantId = uuidv4()
      console.log "participantId: #{participantId}"
      # jsPsych.data.addProperties({
      #   participantId : participantId
      #   experimenterId : Meteor.userId()
      #   experimenterEmail : Meteor.user().emails?[0]?.address
      #   study : "TESTING_0.1"
      # })
      
      $('#please-wait').hide()
      jsPsych.init({
        display_element : $("#jspsych-container")
        fullscreen : true
        show_progress_bar: false
        timeline : timeline 
        on_interaction_data_update: (data) ->
          # (only works >=6.0)
          console.log data 
        exclusions: # i.e. which browsers to exclude (only works >=6.0)
          min_width: 1024,
          min_height: 768
        on_finish : () -> 
          toInsert = {
            participantId : participantId
            experimenterId : Meteor.userId()
            experimenterEmail : Meteor.user().emails?[0]?.address
            experimentName : document.location.pathname.split('/').pop()
            data : jsPsych.data.getData()
            csvData : jsPsych.data.dataAsCSV()
          }
          Meteor.call('data.insert', toInsert, (err, res) ->
            if err
              alert("Error storing data. See console for details. (#{err})") 
              console.log(err)
            jsPsych.data.displayData()
            # for jsPsych >=6.0
            # jsPsych.data.get().localSave('csv', "backup_#{participantId}.csv")
            jsPsych.data.localSave("backup_#{participantId}.csv", 'csv')
          )
      })
    jsPsych.pluginAPI.preloadImages( imagesToPreload, startExp, updateProgress )
    

