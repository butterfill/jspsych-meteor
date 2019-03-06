{ Meteor } = require 'meteor/meteor'
{ Template } = require 'meteor/templating'
{ ReactiveVar } = require 'meteor/reactive-var'

require './abandonedGoalsAdults.html'
{jsPsych} = require '/imports/startup/client/jspsych-6.0.5/jspsych.js'
# require '/imports/startup/client/jspsych-6.0.5/plugins/jspsych-text.js'
# require '/imports/startup/client/jspsych-6.0.5/plugins/jspsych-single-stim.js'
require '/imports/startup/client/jspsych-6.0.5/plugins/jspsych-instructions.js'
require '/imports/startup/client/jspsych-6.0.5/plugins/jspsych-html-keyboard-response.js'

require '/imports/startup/client/jspsych-6.0.5/css/jspsych.css'

uuidv4 = require('uuid/v4')
participantId = uuidv4()
console.log "participantId: #{participantId}"
experimentName = document.location.pathname.split('/').pop()

timeline = []

TESTING = false

addPropsToQs = (qs) ->
  res = []
  for q, idx in qs
    val = switch 
      when idx <= 5 then true
      else false
    cat = switch
      when idx < 4 then 'goal' 
      when idx is 6 or idx is 7 then 'first_half'
      else 'latter_half' 
    res.push({q, val, cat})
  return res

familiarisation = {
  questions : jsPsych.randomization.shuffle addPropsToQs([
    'a blueprint'
    'some tools'
    'the internet'
    'Walmart'
    'a walk'
    'a seafront'
    'a spaceship'
    'a robot'
    'a firework'
    'a retirement'
    'a dinner'
    'some running'
  ])
  stories : {
    complete : [
      'Yasmin had always dreamed of time travel.'
      'She had designed a time machine and wanted to build it.'
      'She bought parts from the Internet.'
      'She bought tools from Walmart.'
      'She laid out the blueprints.'
      'She wasn’t sure it would work.'
      'She built the time machine anyway.'
      'She went for lunch.'
      'She had pasta.'
      'She thought about her childhood.'
      'She wondered what it would be like as an adult.'
      'She finished lunch and went for a walk.'
      'She wondered what the seafront was like in the past.'
      'She walked a long way.'
      'She was tired.'
    ]
    incomplete : [
      'Yasmin had always dreamed of time travel.'
      'She had designed a time machine and wanted to build it.'
      'She bought parts from the Internet.'
      'She bought tools from Walmart.'
      'She laid out the blueprints.'
      'She wasn’t sure it would work.'
      'She would build the machine later.'
      'She went for lunch.'
      'She had pasta.'
      'She thought about her childhood.'
      'She wondered what it would be like as an adult.'
      'She finished lunch and went for a walk.'
      'She wondered what the seafront was like in the past.'
      'She walked a long way.'
      'She was tired.'
    ]
    abandoned : [
      'Yasmin had always dreamed of time travel.'
      'She had designed a time machine and wanted to build it.'
      'She bought parts from the Internet.'
      'She bought tools from Walmart.'
      'She laid out the blueprints.'
      'She wasn’t sure it would work.'
      'She abandoned building a time machine.'
      'She went for lunch.'
      'She had pasta.'
      'She thought about her childhood.'
      'She wondered what it would be like as an adult.'
      'She finished lunch and went for a walk.'
      'She wondered what the seafront was like in the past.'
      'She walked a long way.'
      'She was tired.'
    ]
  }
}

expSets = [
  {
    questions : jsPsych.randomization.shuffle addPropsToQs([
      'a cake'
      'some eggs'
      'a fridge'
      'some baking'
      'a meeting'
      'a workplace'
      'a cinema'
      'a chicken'
      'a demotion'
      'a train'
      'a truck'
      'a lesson'
    ])
    stories : {
      complete : [
        'Betty had just woken up.'
        'She decided to bake a cake.'
        'She got the baking tray.'
        'She got milk out of the fridge.'
        'She cracked the eggs into a bowl.'
        'But then she saw that it was time to go to work.'
        'She had an important meeting that morning.'
        'She finished making the cake quickly.'
        'She got straight in her car.'
        'She drove straight to work.'
        'She arrived and went straight to her morning meeting.'
        'At the meeting, Betty’s boss asked her to present her latest findings.'
        'She was nervous, but presented confidently.'
        'Her presentation was well received.'
        'After the meeting, the boss offered Betty a promotion.'
      ]
      incomplete : [
        'Betty had just woken up.'
        'She decided to bake a cake.'
        'She got the baking tray.'
        'She got milk out of the fridge.'
        'She cracked the eggs into a bowl.'
        'But then she saw that it was time to go to work.'
        'She had an important meeting that morning.'
        'She would finish the cake later.'
        'She got straight in her car.'
        'She drove straight to work.'
        'She arrived and went straight to her morning meeting.'
        'At the meeting, Betty’s boss asked her to present her latest findings.'
        'She was nervous, but presented the confidently.'
        'Her presentation was well received.'
        'After the meeting, the boss offered Betty a promotion.'
      ]
      abandoned : [
        'Betty had just woken up.'
        'She decided to bake a cake.'
        'She got the baking tray.'
        'She got milk out of the fridge.'
        'She cracked the eggs into a bowl.'
        'But then she saw that it was time to go to work.'
        'She had an important meeting that morning.'
        'She would not make the cake.'
        'She got straight in her car.'
        'She drove straight to work.'
        'She arrived and went straight to her morning meeting.'
        'At the meeting, Betty’s boss asked her to present her latest findings.'
        'She was nervous, but presented the confidently.'
        'Her presentation was well received.'
        'After the meeting, the boss offered Betty a promotion.'
      ]
    }
  }

  {
    questions : jsPsych.randomization.shuffle addPropsToQs([
      'some laundry'
      'some clothes'
      'a basket'
      'some detergent'
      'washing up'
      'a vacuum'
      'a doctor'
      'a phone'
      'a cake'
      'a bus'
      'a dentist'
      'a courthouse'
    ])
    stories : {
      complete : [
        'Dave was having a quiet night in.'
        'He noticed he’d run out of clean clothes.'
        'He decided to put in a load of laundry.'
        'He collected the wash basket.'
        'He got some detergent.'
        'Then he heard the phone ring.'
        'Dave quickly put on the wash '
        'The he answered the phone.'
        'He received terrible news.'
        'Dave needed to get to the hospital – he finished doing laundry'
        'He rushed straight outside.'
        'He flagged the first taxi he saw.'
        'When he arrived he asked where Sandra was.'
        'Nobody knew.'
        'Dave was terrified.'
        'His worst fears were about to come true.'
      ]
      incomplete : [
        'Dave was having a quiet night in.'
        'He noticed he’d run out of clean clothes.'
        'He decided to put in a load of laundry.'
        'He collected the wash basket.'
        'He got some detergent.'
        'Then he heard the phone ring.'
        'Dave paused doing the wash '
        'Then he answered the phone.'
        'He received terrible news.'
        'Dave needed to get to the hospital – the laundry could wait.'
        'He rushed straight outside.'
        'He flagged the first taxi he saw.'
        'When he arrived he asked where Sandra was.'
        'Nobody knew.'
        'Dave was terrified.'
        'His worst fears were about to come true.'
      ]
      abandoned : [
        'Dave was having a quiet night in.'
        'He noticed he’d run out of clean clothes.'
        'He decided to put in a load of laundry.'
        'He collected the wash basket.'
        'He got some detergent.'
        'Then he heard the phone ring.'
        'Dave abandoned doing the wash '
        'Then he answered the phone.'
        'He received terrible news.'
        'Dave needed to get to the hospital – he abandoned the laundry.'
        'He rushed straight outside.'
        'He flagged the first taxi he saw.'
        'When he arrived he asked where Sandra was.'
        'Nobody knew.'
        'Dave was terrified.'
        'His worst fears were about to come true.'
      ]
    }
  }

  {
    questions : jsPsych.randomization.shuffle addPropsToQs([
      'a sock'
      'a washroom'
      'a basket'
      'a bed'
      'a suit'
      'a hoover'
      'a taxi'
      'a drink'
      'a cake'
      'some cooking'
      'a tracksuit'
      'a cinema'
    ])
    stories : {
      complete : [
        'Fiona had lost a sock in the wash.'
        'She was looking for the sock.'
        'But she was thinking about her upcoming date.'
        'She looked in the wash basket.'
        'She looked in the washroom.'
        'She looked under the bed.'
        'But, either way, she needed to leave soon.'
        'Just then, she spotted the sock.'
        'She called a taxi and headed out.'
        'She told the driver to go straight to Central Square '
        'Upon arriving she could see James standing in the rain.'
        'He had an umbrella and was wearing a nice suit.'
        'Fiona paid the taxi driver and ran to meet James.'
        'He had bought tickets for the theatre.'
        'They grabbed a drink.'
        'The atmosphere was very nice.'
      ]
      incomplete : [
        'Fiona had lost a sock in the wash.'
        'She was looking for the sock.'
        'But she was thinking about her upcoming date.'
        'She looked in the wash basket.'
        'She looked in the washroom.'
        'But, either way, she needed to leave soon.'
        'She would find the sock later.'
        'She called a taxi and headed out.'
        'She told the driver to go straight to Central Square.'
        'Upon arriving she could see James standing in the rain.'
        'He had an umbrella and was wearing a nice suit.'
        'Fiona paid the taxi driver and ran to meet James.'
        'He had bought tickets for the theatre.'
        'They grabbed a drink.'
        'The atmosphere was very nice.'
      ]
      abandoned : [
        'Fiona had lost a sock in the wash.'
        'She was looking for the sock.'
        'But she was thinking about her upcoming date.'
        'She looked in the wash basket.'
        'She looked in the washroom.'
        'But, either way, she needed to leave soon.'
        'She decided to forget the sock.'
        'She called a taxi and headed out.'
        'She told the driver to go straight to Central Square.'
        'Upon arriving she could see James standing in the rain.'
        'He had an umbrella and was wearing a nice suit.'
        'Fiona paid the taxi driver and ran to meet James.'
        'He had bought tickets for the theatre.'
        'They grabbed a drink.'
        'The atmosphere was very nice.'
      ]
    }
  }

  {
    questions : jsPsych.randomization.shuffle addPropsToQs([
      'a planet'
      'a scan'
      'Zorton'
      'a surface'
      'a moon'
      'a boat'
      'a collision'
      'Skype'
      'G-Chat'
      'an outpost'
      'a near miss'
      'a servant'
    ])
    stories : {
      complete : [
        'Dave was aboard a starship, headed for the planet Zorton.'
        'His mission was to run a routine scan of the planet’s surface.'
        'He neared the planet.'
        'He turned on the ship’s breaks.'
        'He pointed the scanning equipment towards Zorton.'
        'He was ready to begin the scan.'
        'Then an alarm went off.'
        'Dave completed the scan.'
        'He checked the ship’s diagnostics.'
        'The ship’s hull had sustained a minor collision.'
        'He opened Skype.'
        'He immediately contacted central headquarters.'
        'His boss asked him if he had detected anything abnormal on the mission.'
        'He hadn’t.'
        'Dave felt a second collision.'
        'Skype cut out.'
      ]
      incomplete : [
        'Dave was aboard a starship, headed for the planet Zorton.'
        'His mission was to run a routine scan of the planet’s surface.'
        'He neared the planet.'
        'He turned on the ship’s breaks.'
        'He pointed the scanning equipment towards Zorton.'
        'He was ready to begin the scan.'
        'Then an alarm went off.'
        'Dave interrupted the scan.'
        'He checked the ship’s diagnostics.'
        'The ship’s hull had sustained a minor collision.'
        'He opened Skype.'
        'He immediately contacted central headquarters.'
        'His boss asked him if he had detected anything abnormal on the mission.'
        'He hadn’t.'
        'Dave felt a second collision.'
        'Skype cut out.'
      ]
      abandoned : [
        'Dave was aboard a starship, headed for the planet Zorton.'
        'His mission was to run a routine scan of the planet’s surface.'
        'He neared the planet.'
        'He turned on the ship’s breaks.'
        'He pointed the scanning equipment towards Zorton.'
        'He was ready to begin the scan.'
        'Then an alarm went off.'
        'Dave abandoned the scan.'
        'He checked the ship’s diagnostics.'
        'The ship’s hull had sustained a minor collision.'
        'He opened Skype.'
        'He immediately contacted central headquarters.'
        'His boss asked him if he had detected anything abnormal on the mission.'
        'He hadn’t.'
        'Dave felt a second collision.'
        'Skype cut out.'
      ]
    }
  }

  {
    questions : jsPsych.randomization.shuffle addPropsToQs([
      'some wood'
      'a forest'
      'some walking'
      'a village'
      'some villagers'
      'some screaming'
      'a swamp'
      'some cooking'
      'a griffin'
      'a gun'
      'some flying'
      'the mayor'
    ])
    stories : {
      complete : [
        'The village needed wood for cooking.'
        'Lancelot decided to go find some.'
        'He went outside.'
        'He walked to the forest.'
        'He began looking for good pieces of wood.'
        'He found some pieces and took them back to the village.'
        'Then a Forest Dragon appeared.'
        'It breathed fire on the villagers.'
        'The villagers screamed in terror.'
        'Lancelot knew what he needed to do.'
        'He took his sword from its sheath.'
        'He ran towards the dragon.'
        'He struck its wing.'
        'The dragon could no longer fly.'
        'Lancelot knew victory was his.'
      ]
      incomplete : [
        'The village needed wood for cooking.'
        'Lancelot decided to go find some.'
        'He went outside.'
        'He walked to the forest.'
        'He began looking for good pieces of wood.'
        'He would look again later but went back to the village.'
        'Then a Forest Dragon appeared.'
        'It breathed fire on the villagers.'
        'The villagers screamed in terror.'
        'Lancelot knew what he needed to do.'
        'He took his sword from its sheath.'
        'He ran towards the dragon.'
        'He struck its wing.'
        'The dragon could no longer fly.'
        'Lancelot knew victory was his.'
      ]
      abandoned : [
        'The village needed wood for cooking.'
        'Lancelot decided to go find some.'
        'He went outside.'
        'He walked to the forest.'
        'He began looking for good pieces of wood.'
        'There was no wood, so he went back to the village.'
        'Then a Forest Dragon appeared.'
        'It breathed fire on the villagers.'
        'The villagers screamed in terror.'
        'Lancelot knew what he needed to do.'
        'He took his sword from its sheath.'
        'He ran towards the dragon.'
        'He struck its wing.'
        'The dragon could no longer fly.'
        'Lancelot knew victory was his.'
      ]
    }
  }

  {
    questions : jsPsych.randomization.shuffle addPropsToQs([
      'a shave'
      'a razor'
      'some foam'
      'a face'
      'a gun'
      'a drawer'
      'a bath'
      'some scissors'
      'a dog'
      'an attic'
      'a knife'
      'some jumping'
    ])
    stories : {
      complete : [
        "Agent 006 was in Moscow."
        'His source told him to stay well shaven.'
        'So he decided to shave.'
        'He grabbed his razor.'
        'He applied shaving foam to his face.'
        'But then he heard a noise from the bedroom.'
        'He finished shaving quickly, and went to investigate.'
        'He went to investigate.'
        'He walked through to the bedroom.'
        'A man was looking through his drawer.'
        "006 grabbed his gun."
        'The man saw.'
        "006 fired three shots."
        'The man recoiled and then collapsed.'
        
      ]
      incomplete : [
        'His source told him to stay well shaven.'
        'So he decided to shave.'
        'He grabbed his razor.'
        'He applied shaving foam to his face.'
        'But then he heard a noise from the bedroom.'
        'He decided to investigate before continuing his shave.'
        'He went to investigate.'
        'He walked through to the bedroom.'
        'A man was looking through his drawer.'
        "006 grabbed his gun."
        'The man saw.'
        "006 fired three shots."
        'The man recoiled and then collapsed.'
        "006 went to investigate the body."
      ]
      abandoned : [
        "Agent 006 was in Moscow."
        'His source told him to stay well shaven.'
        'So he decided to shave.'
        'He grabbed his razor.'
        'He applied shaving foam to his face.'
        'But then he heard a noise from the bedroom.'
        'He abandoned his shaving and went to investigate.'
        'He went to investigate.'
        'He walked through to the bedroom.'
        'A man was looking through his drawer.'
        "006 grabbed his gun."
        'The man saw.'
        "006 fired three shots."
        'The man recoiled and then collapsed.'
        "006 went to investigate the body."
      ]
    }
  }
]
familiarisationStoryType = (jsPsych.randomization.shuffle [
  'complete'
  'incomplete'
  'abandoned'
]).pop()
familiarisation.condition = "familiarisation-#{familiarisationStoryType}"
familiarisation.story = familiarisation.stories[familiarisationStoryType]
familiarisation.storyId = 99
expConditionOrder = jsPsych.randomization.shuffle [
  'complete'
  'incomplete'
  'abandoned'
  'complete'
  'incomplete'
  'abandoned'
]
for e, idx in expSets
  condition = expConditionOrder[idx]
  e.condition = condition
  e.story = e.stories[condition]
  e.storyId = idx
expSets = jsPsych.randomization.shuffle(expSets)
storyIdOrder = (e.storyId for e in expSets)
console.log storyIdOrder



# -----
# functions to create stimuli and prompts

createInstructions = (inst) ->
  res = []
  for page in inst
    trial_duration = 4000
    trial_duration = 2000 if page.length < 100
    trial_duration = 0 if TESTING
    res.push {
      type : 'html-keyboard-response'
      show_clickable_nav: false
      key_forward : jsPsych.NO_KEYS
      trial_duration : trial_duration
      response_ends_trial : false
      stimulus : page
      timing_post_trial: 0
      data : {
        condition : 'delayForReadingInstructions'
      }
    }
    res.push {
      type : 'instructions'
      show_clickable_nav: false
      key_forward : 32   # space bar
      pages : ["#{page}<p>&nbsp;</p><p>When you are ready, press the space bar to continue.</p>"]
      timing_post_trial: 0
    }
  return res

on_finish = (data) ->
  if data.key_press is 78 # i.e. 'n'
    data.response_key = 'n'
    if data.value is false
      data.is_correct = true
    else
      data.is_correct = false
  else
    data.response_key = 'b'
    if data.value is true
      data.is_correct = true
    else
      data.is_correct = false

# This only used for Is snow white? etc
createFamQuestions = (sentences, condition) ->
  timing_post_trial = 0
  return {
    type : 'html-keyboard-response'
    is_html : true
    timeline : ({
      stimulus :"<p>Question:</p><p style='margin-top:200px; margin-left:25px; font-size: 18pt'>#{sentence.q}</p>"
      data: {
        sentence 
        condition
        value : sentence.val
        }
      } for sentence in sentences)
    choices : ['B', 'N']
    timing_post_trial : timing_post_trial
    on_finish : on_finish
  }

createQuestions = (sentences, e) ->
  timing_post_trial = 0
  return {
    type : 'html-keyboard-response'
    is_html : true
    timeline : ({
      stimulus :"""
        <p>Question:</p>
        <p style='margin-top:200px; margin-left:25px; font-size: 18pt'>Did the story mention #{sentence.q}?</p>
      """
      data: {
        sentence
        condition : e.condition
        storyId : e.storyId
        value : sentence.val
        category : sentence.cat
      }
    } for sentence in sentences)
    choices : ['B', 'N']
    timing_post_trial : timing_post_trial
    on_finish : on_finish

  }

createLinesOfStory = (sentences, e) ->
  return {
    type : 'html-keyboard-response'
    is_html : true
    timeline :  ({
      stimulus: """<p style='font-size: 18pt;margin-top:200px; margin-left:25px;'>#{s}</p>"""
      data: {
          sentence : s
          condition : e.condition
          storyId : e.storyId
        }
      } for s in sentences)
    choices : [' ']
    timing_post_trial: 0
  }


addAllToTimeline = (timeline, trials) ->
  timeline.push(t) for t in trials

# --------------
# timeline construction
addAllToTimeline timeline, createInstructions([
  """
    <p>Welcome to the experiment.</p>
    <p>&nbsp;</p>
    <p>Before we start, here is some practice. </p>
    <p>On the next screens, you will see a series of questions .</p>
    <p>When you see a question,</p>
    <p style='margin-left:2em;'>if the answer is yes, you should press ‘b’ (for YES);</p>
    <p style='margin-left:2em;'>if the answer is no, you should press ‘n’ (for NO). </p>
  """
])

# a practice where it tells you which key to press!
timeline.push({
  type : 'html-keyboard-response'
  is_html : true
  timeline : [
      {
        stimulus :"""
          <p>Question:</p>
          <p style='margin-top:200px; margin-left:25px; font-size: 18pt'>Is water wet?</p>
          <p  style='margin-left:25px;'>The answer is yes. So you press 'b' for yes.</p>      
        """
        choices : ['B']
      }
      {
        stimulus :"""
          <p>Question:</p>
          <p style='margin-top:200px; margin-left:25px; font-size: 18pt'>Is ice hot?</p>
          <p style='margin-left:25px;'>The answer is no. So you press 'n' for no.</p>      
        """
        choices : ['N']
      }
    ]
  data: {
    condition: 'familiarization-0-forced'
  }
  timing_post_trial : 0
})

# some practice questions with no instructions about what key to press
famQ = jsPsych.randomization.shuffle([
  {q:'Is snow white?', val:true}
  {q:'Does one plus one equal two?', val:true}
  {q:'Does one plus two equal one', val:false}
  {q:'Can touching fire burn you?', val:true}
  {q:'Is snow black?', val:false}
  {q:'Is inhaling cigarette smoke bad for young children?', val:true}
  {q:'Is smoking tobacco good for young children?', val:false}
  {q:'Can birds fly?', val:true}
  {q:'Can pigs fly?', val:false}
])
timeline.push(createFamQuestions(famQ, 'familiarization-1'))

storyInstructions = """
  <p>Please read the following story carefully.</p>
  <p>When you have read a line of the story,</p>
  <p>&nbsp;</p>
  <p>After the story you will be asked to answer some questions about it.</p>
  <p>&nbsp;</p>
  <p>When you want to answer a question,</p>
  <p style='margin-left:2em;'>if the answer is yes, you should press ‘b’ (for YES);</p>
  <p style='margin-left:2em;'>if the answer is no, you should press ‘n’ (for NO). </p>
"""

addAllToTimeline timeline, createInstructions([
  """
    <p>That’s the end of the practice. Now for the experiment.</p>
  """
  storyInstructions
])

# --------------
# familiarization story

timeline.push createLinesOfStory( familiarisation.story, familiarisation )
timeline.push createQuestions( familiarisation.questions, familiarisation )

# --------------
# familiarization story

for e in expSets
  addAllToTimeline timeline, createInstructions([
    """
      <p>That’s the end of those questions. Now for another story.</p>
    """
    storyInstructions
  ])
  timeline.push createLinesOfStory( e.story, e )
  timeline.push createQuestions( e.questions, e )


# -----------------
# events control
@expComplete = new ReactiveVar()
expComplete.set('')

startExperiment = () ->
  jsPsych.init({
    display_element : "jspsych-container"
    # fullscreen : true
    show_progress_bar: false
    timeline : timeline 
    exclusions: # i.e. which browsers to exclude (only works >=6.0)
      min_width: 1024,
      min_height: 768
    on_finish : () -> 
      jsPsych.data.addProperties({
        participantId 
        familiarisationStoryType
        expConditionOrder
        storyIdOrder
        experimenterId : Meteor.userId() or ''
        experimenterEmail : Meteor.user()?.emails?[0]?.address or ''
        experimentName : document.location.pathname.split('/').pop()
      })
      toInsert = {
        participantId 
        familiarisationStoryType
        expConditionOrder
        storyIdOrder
        experimenterId : Meteor.userId() or ''
        experimenterEmail : Meteor.user()?.emails?[0]?.address or ''
        experimentName 
        data : JSON.parse(jsPsych.data.get().json())
        csvData : jsPsych.data.get().csv()
      }
      Meteor.call('data.insert', toInsert, (err, res) ->
        if err
          alert("Error storing data. See console for details. (#{err})") 
          console.log(err)
        expComplete.set('g6hjs38')
        $('#jspsych-container').hide()
        $('#afterTheExperiment').show()
        # jsPsych.data.displayData('json')
        console.log jsPsych.data.displayData('json')
        # jsPsych.data.get().localSave('csv', "backup_#{participantId}.csv")
      )
  })

# Template.App_abandonedGoalsAdults.onRendered () ->
#   $('#please-wait').hide()

toast = (msg) ->
  Materialize.toast(msg, 4000)

Template.App_abandonedGoalsAdults.helpers
  mTurkCode : () -> expComplete.get()

Template.App_abandonedGoalsAdults.events
  'click #startExperiment' : (event, instance) ->
    console.log 'start'
    consent = $("#consent").prop('checked')
    age = parseInt($('#age').val())
    gender = $('input[name="gender"]:checked').prop('value')
    genderDesc = $('#genderDesc').val()
    proceed = true
    unless consent is true
      proceed = false
      toast "Please confirm you have read and understood the information."
    unless _.isFinite(age)
      proceed = false
      toast "Please enter you age, which must be a number in years, e.g. 21."
    unless gender?
      proceed = false
      toast "Please specify a gender or indicate that you would prefer not to answer."
    if proceed
      Materialize.Toast.removeAll()
      toast "Saving your data ..."
      toInsert = {
        participantId 
        experimentName 
        experimenterId : Meteor.userId() or ''
        experimenterEmail : Meteor.user()?.emails?[0]?.address or ''
        consent
        gender
        genderDesc
        age
      }
      Meteor.call 'personalInfo.insert', toInsert, (err, res) ->
        Materialize.Toast.removeAll()
        if err
         toast "Error storing your data. Sorry, cannot continue (#{err})"
        else
          $('#introAndConsent').hide()
          $('#jspsych-container').show()
          startExperiment()