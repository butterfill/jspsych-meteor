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

window.expSets = [
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
        'Dave needed to get to the hospital immediately – XXXX'
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
        'Dave needed to get to the hospital immediately – the laundry could wait.'
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
        'Dave needed to get to the hospital immediately – he abandoned the laundry.'
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
      'Did the story the mayor'
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
        '20.	But then he heard a noise from the bedroom.'
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
expConditionOrder = jsPsych.randomization.shuffle [
  'complete'
  'incomplete'
  'abandoned'
  'complete'
  'incomplete'
  'abandoned'
]
for e, idx in expSets
  condition = expConditionOrder.pop()
  e.condition = condition
  e.story = e.stories[condition]
  e.storyId = idx
expSets = jsPsych.randomization.shuffle(expSets)
createInstructions = (inst) ->
  return {
    type : 'instructions'
    show_clickable_nav: true
    key_forward : 32   # space bar
    pages : inst
    timing_post_trial: 0
  }
  
# instructions need updating! (or keep)
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


createQuestions = (sentences, condition) ->
  if TESTING
    timing_post_trial = 0
  else
    timing_post_trial = undefined
  return {
    type : 'single-stim'
    is_html : true
    timeline : ({
      stimulus :"<p>Question:</p><p style='margin-top:200px; margin-left:25px; font-size: 18pt'>Did the story mention #{sentence.q}?</p>"
      data: {
        value : sentence.val
        category : sentence.cat
        condition
        }
      } for sentence in sentences)
    choices : ['B', 'N']
    # prompt : '<p>Is this sentence true or false? Press ‘b’ for TRUE or ‘n’ for FALSE.</p>'
    timing_post_trial : timing_post_trial
  }

createLinesOfStory = (sentences) ->
  return {
    type : 'single-stim'
    is_html : true
    timeline :  ({stimulus:"<p style='font-size: 18pt'>#{s}</p>"} for s in sentences)
    choices : [' ']
    prompt : '<p>Press the space bar to continue.</p>'
    timing_post_trial: 0
  }


# --------------
# trainingBlock1 
  
timeline.push createQuestions([
  {q:'Snow is white.'}
  {q:'Touching fire can burn you.'}
  {q:'Snow is black.'}
  {q:'Inhaling cigarette smoke is bad for young children.'}
])


timeline.push createInstructions([
  """
    <p>That’s the end of the practice. Now for the experiment. Press the space bar to advance to the next slide.</p>
  """
  """
    <p>Please read the following story carefully.  After the story you will be asked to answer some questions about it.</p>
  """
])

# --------------
# familiarization story

timeline.push createLinesOfStory( familiarisation.stories.complete )
timeline.push createQuestions( familiarisation.questions, 'familiarisation' )

# --------------
# familiarization story

for e in expSets
  timeline.push createLinesOfStory( e.story )
  timeline.push createQuestions( e.questions, e.condition )


# --------------
# story1 

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
    

