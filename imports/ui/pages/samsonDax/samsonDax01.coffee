{ Meteor } = require 'meteor/meteor'
{ Template } = require 'meteor/templating'

require './samsonDax01.html'
{jsPsych} = require '/imports/startup/client/jspsych-5.0.3/jspsych.js'
require '/imports/startup/client/jspsych-5.0.3/plugins/jspsych-text.js'
require '/imports/startup/client/jspsych-5.0.3/plugins/jspsych-single-stim.js'
require '/imports/startup/client/jspsych-5.0.3/plugins/jspsych-instructions.js'

require '/imports/startup/client/jspsych-5.0.3/css/jspsych.css'

uuidv4 = require('uuid/v4')

timeline = []

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
    <p>Welcome the the experiment. Press the space bar to advance to the next slide.</p>
  """
  """
    <p>This is the discs task.</p>
    <p>On each trial, the first thing that you are going to see is a fixation cross (like this: +). </p>
    <p>It is important that you look at the cross, because it will quickly be replaced  with a  number (from 0 to 3). </p>
    <p>After seeing the number, you will look inside of a room that will have either 0, 1, 2, or 3 red discs hanging on the walls. </p>
    <p>If the number of discs on the walls matches the number you have just seen, press 'b' (for YES). </p>
    <p>If the number of discs on the wall does NOT match the number you have just seen press 'n' (for NO). </p>
  """
  # §ISSUE I’m confused by the instruction ‘Press the space bar to walk through 
  # this process’ because I need to press the B key
  """
    <p>Before we start, here is some practice. </p>
    <p>On the next screen, you will see the cross (+), the number ‘0’, and then you will see a room with 0 discs hanging on the wall.</p>
    <p>Because the number of discs matches the number, you should press ‘b’ (for YES). </p>
    <p>Press the space bar to walk through this process. </p>
  """
])

# --------------
# trainingBlock1 

# §ISSUE how long should the cross appear for?
createCross = () ->
  return {
    type : 'single-stim'
    stimulus : '/img/samsonDax/cross.jpg'
    timing_stim : 1000
    timing_response : 1000
    response_ends_trial : false
    timing_post_trial: 0
  }
  
# §ISSUE how long should the numeral appear for?
createImgStimulus = (fileNameInclPath) ->
  return {
    type : 'single-stim'
    stimulus : fileNameInclPath
    timing_stim : 1000
    timing_response : 1000
    response_ends_trial : false
    timing_post_trial: 0
  }
createNum = (num) -> createImgStimulus("/img/samsonDax/num#{num}.jpg")
createYOU = () -> createImgStimulus("/img/samsonDax/you.jpg")  
createDAX = () -> createImgStimulus("/img/samsonDax/dax.jpg")  

timeline.push createCross()
timeline.push createNum(0)
# §ISSUE In this trial, shouldn’t there be a timeout condition (say 30 sec),
# after which the participant sees a ‘let’s try that again’ screen?
timeline.push 
  type : 'single-stim'
  stimulus : '/img/samsonDax/stimuliPics-SkSa2016-E1/0000.jpg'
  choices : ['B']
  timing_response : -1
  response_ends_trial : true

timeline.push createInstructions([
  """
    <p>NICE! </p>
    <p>In the next example, you will see the cross, the number ‘3’, and then a room with two discs on the wall. </p>
    <p>In this trial, you would press ‘n’ for NO, because the number of discs does NOT match the numeral you saw. </p>
    <p>Press the space bar to walk through this process. </p>
  """
])
timeline.push createCross()
timeline.push createNum(3)
timeline.push 
  type : 'single-stim'
  stimulus : '/img/samsonDax/Train_fam_full/Training1.jpg'
  choices : ['N']
  timing_response : -1
  response_ends_trial : true
  

timeline.push createInstructions([
  """
    <p>Later on, you will be doing this on your own and for a longer period of time. </p>
    <p>You will have 2 seconds to give a yes or no answer on each trial, so please respond as quickly and as accurately as you can. </p>
    <p>Let’s do a little more practice before you begin. </p>
    <p>Press the spacebar to start.</p>
  """
])

# Displays a cross, then a number (`num`), then the image specified by `imgName`
# data is an object which should contain `numberMatchesDots`. 
insertTrainingStim = (num, imgName, data) ->
  timeline.push createCross()
  timeline.push createNum(num)
  data.block = 'TRAINING_PART_1'
  # §ISSUE Should the choice be only the correct option?
  # should I have already imposed the 2 sec time limit?
  timeline.push 
    type : 'single-stim'
    stimulus : "/img/samsonDax/Train_fam_full/#{imgName}"
    choices : ['B','N']
    timing_response : 2000
    response_ends_trial : true
    data : data
    on_finish : (data) ->
      correct = false
      if data.numberMatchesDots and data.key_press is 66 # 66 is B
        correct = true
      if not data.numberMatchesDots and data.key_press is 78 # 78 is N
        correct = true
      jsPsych.data.addDataToLastTrial({responseIsCorrect: correct})
    

insertTrainingStim(1, 'Training2.jpg', {numberMatchesDots:true} )  
insertTrainingStim(2, 'Training1.jpg', {numberMatchesDots:true} )  
insertTrainingStim(3, 'Training3.jpg', {numberMatchesDots:true} )  
# §ISSUE from here on, PPT did not specify which numbers to show so I made them up
insertTrainingStim(2, 'Training4.jpg', {numberMatchesDots:false} )  
insertTrainingStim(1, 'Training5.jpg', {numberMatchesDots:false} )  
insertTrainingStim(3, 'Training6.jpg', {numberMatchesDots:true} )  
insertTrainingStim(0, 'Training7.jpg', {numberMatchesDots:false} )  
insertTrainingStim(1, 'Training8.jpg', {numberMatchesDots:false} )  
insertTrainingStim(3, 'Training9.jpg', {numberMatchesDots:true} )  

# end of practice block 1
# §ISSUE Should we report accuracy to participant?
# §ISSUE What do we do if accuracy is low?
# -----------------------------------------------



# -----------------------------------------------
# Familiarization part 1: interactive encounter

timeline.push createInstructions([
  """
    <p>Okay, your first practice is over. You will get another chance to practice later on. </p>
    <p>Before you do the task on your own, you will view a few more slides.</p>
    <p>Press the spacebar to continue. </p>
  """
  ("<img src='/img/samsonDax/Train_fam_full/Fam#{x}.jpg' />" for x in [1..22])...
])


# -----------------------------------------------
# Familiarization part 2: agent/mineral contrast task
timeline.push createInstructions(
  ("<img src='/img/samsonDax/Train_fam_full/FamP2_#{x}.jpg' />" for x in [1..3])
)

blicketMineralStimuli = [
  {
    stimulus : '/img/samsonDax/Train_fam_full/FamP2_4.jpg'
    data :
      isDax : false
      block : 'FAMILIARIZATION_PART_2'
  }
  {
    stimulus : '/img/samsonDax/Train_fam_full/FamP2_5.jpg'
    data :
      isDax : false
      block : 'FAMILIARIZATION_PART_2'
  }
  {
    stimulus : '/img/samsonDax/Train_fam_full/FamP2_6.jpg'
    data :
      isDax : false
      block : 'FAMILIARIZATION_PART_2'
  }
  {
    stimulus : '/img/samsonDax/Train_fam_full/FamP2_7.jpg'
    data :
      isDax : true
      block : 'FAMILIARIZATION_PART_2'
  }
  {
    stimulus : '/img/samsonDax/Train_fam_full/FamP2_8.jpg'
    data :
      isDax : true
      block : 'FAMILIARIZATION_PART_2'
  }
  {
    stimulus : '/img/samsonDax/Train_fam_full/FamP2_9.jpg'
    data :
      isDax : true
      block : 'FAMILIARIZATION_PART_2'
  }
]
timeline.push
  type : 'single-stim'
  choices : [32]  # 32 = space
  # §ISSUE How long should subjects have to detect the blicket?
  timing_response: 2000 
  # §ISSUE How long should the delay between trials be?
  timing_post_trial : 250
  timeline : jsPsych.randomization.repeat(blicketMineralStimuli, 3)
  on_finish : (data) ->
    correct = false
    if data.isDax and data.rt > -1
      correct = true
    if not data.isDax and data.rt is -1
      correct = true
    jsPsych.data.addDataToLastTrial({responseIsCorrect: correct})


# §ISSUE  there's a mistake in the instructions: '[KEY]' instead of 'spacebar' 
# or whatever.
# I’ve assumed '[KEY]' should be 'spacebar'. But the image still needs updating.
timeline.push createInstructions([
  "<img src='/img/samsonDax/Train_fam_full/FamP2_10.jpg' />"
])
# exactly as before except that you should press spacebar when mineral, not when dax
# NB: I didn’t use FamP2_11 ... FamP2_16 because I think these are identical to
# FamP2_4 ... FamP2_9
timeline.push
  type : 'single-stim'
  choices : [32]  # 32 = space
  # §ISSUE How long should subjects have to detect the blicket?
  timing_response: 2000 
  # §ISSUE How long should the delay between trials be?
  timing_post_trial : 250
  timeline : jsPsych.randomization.repeat(blicketMineralStimuli, 3)
  on_finish : (data) ->
    correct = false
    # THESE ARE REVERSED COMPARED TO PREVIOUS SET:
    if not data.isDax and data.rt > -1
      correct = true
    if data.isDax and data.rt is -1
      correct = true
    jsPsych.data.addDataToLastTrial({responseIsCorrect: correct})



# ----------------------------------------




timeline.push createInstructions([
  "<img src='/img/samsonDax/Train_fam_full/FamP2_17.jpg' />"
  """
    <p>Now you will complete a different version of the discs task.</p>
    <p>On each trial, you will first see a fixation cross (+). </p>
    <p>It is important that you look at the cross, because it will quickly be replaced by either the word ‘YOU’ or the word ‘DAX’.</p>
    <p>Then the word will be replaced by a number from 0 to 3. </p>
    <p>Next, an image of a room with 0, 1, 2, or 3 red disks on the walls. You will also see Dax in the middle of the room.</p>
  """
  """
    <p>On half of the trials, you must check if the number corresponds to how many discs <u>you can see</u> from <u>your perspective</u>.</p>
    <p>On the other half of the trials, you must check if the number corresponds to how many discs <u>Dax can see</u> from <u>Dax’s perspective</u>.</p>
  """
  """
    <p>When you first see the word ‘YOU’, you must check whether the number of discs on the walls <u><i>that you can see</i></u> matches the number just displayed on the screen. </p>
    <p>When you first see the word ‘DAX’, you must check whether the number of discs on the walls <u><i>that Dax can see</i></u> matches the number just displayed on the screen. </p>
    <p>Press ‘b’ for YES and ‘n’ for NO.</p>
    
  """
  """
    <p>For example, on the next slide, you will first see the word ‘YOU’, and then the number ‘0’. Then you will see a room with 0 discs. </p>
    <p>In this trial, you would press ‘b’ for YES, because the number matches the number of discs that <u><i>you can see</i></u>.</p>
  """
])
timeline.push createCross()
timeline.push createYOU()
timeline.push createNum(0)
# §ISSUE In this trial, shouldn’t there be a timeout condition (say 30 sec),
# after which the participant sees a ‘let’s try that again’ screen?
timeline.push 
  type : 'single-stim'
  stimulus : '/img/samsonDax/stimuliPics-SkSa2016-E1/0S00.jpg'
  choices : ['B']
  timing_response : -1
  response_ends_trial : true

timeline.push createInstructions([
  """
    <p>On the next slide, you will first see the word YOU, and then the number ‘3’. Then you will see a room with 2 discs. </p>
    <p>In this trial, you would press ‘n’ for NO, because the number does <u>not</u> match the number of discs <u><i>that you can see</i></u>.</p>
  """
])
timeline.push createCross()
timeline.push createYOU()
timeline.push createNum(3)
timeline.push 
  type : 'single-stim'
  stimulus : '/img/samsonDax/stimuliPics-SkSa2016-E1/0S11.jpg'
  choices : ['N']
  timing_response : -1
  response_ends_trial : true

timeline.push createInstructions([
  """
    <p>On the next slide, you will first see the word DAX, and then the number ‘2’. Then you will see a room with 2 discs that Dax <u>can</u> see.</p>
    <p>In this trial, you would press ‘b’ for YES, because the number matches the number of discs <u><i>that Dax can see</i></u>.</p>
  """
])
timeline.push createCross()
timeline.push createDAX()
timeline.push createNum(2)
timeline.push 
  type : 'single-stim'
  stimulus : '/img/samsonDax/stimuliPics-SkSa2016-E1/0S02.jpg'
  choices : ['B']
  timing_response : -1
  response_ends_trial : true

timeline.push createInstructions([
  """
    <p>On the next slide, you will first see the word ‘DAX’, and then the number ‘3’. Then you will see a room with 3 discs that Dax <u>cannot see</u>. </p>
    <p>In this trial, you would press ‘n’ for NO, because the number does <u>not</u> match the number of discs <u><i>that Dax can see</i></u>.</p>
  """
])
timeline.push createCross()
timeline.push createDAX()
timeline.push createNum(3)
timeline.push 
  type : 'single-stim'
  stimulus : '/img/samsonDax/stimuliPics-SkSa2016-E1/0S30.jpg'
  choices : ['N']
  timing_response : -1
  response_ends_trial : true




# ----------------------------------------




# §ISSUE I removed the line about 4 test blocks since that information can be given
# later, nearer to the time it’s relevant.
timeline.push createInstructions([
  """
    <p>Now let’s start with a practice block consisting of 26 trials.</p>
    <p>For each trial, you have a maximum of 2 seconds to respond. <b>Please try to be as quick as possible while making as few mistakes as possible.</b></p>
    <p>Thanks again for your participation!</p>
    <p>Press the spacebar to start.</p>
  """
])

# build list of functions for all possible trials (80 in total, assuming just one for each image where the correct answer is no)
# §ISSUE: How do we pick the number to be verified by participants when
# the number is incorrect?  What I’ve done: the number to verify is correct from the 
# opposite perspective, unless the two perspectives are the same: in that case, the number
# is one different (alternately less/more) from the correct number.
createAllTrials = (blockName) ->
  youYesTrials = []   # yes : ie correct answer is yes
  youNoTrials = []
  daxYesTrials = []
  daxNoTrials = []
  didPlusOneLastTime = false
  for daxIsFacing in ['left','right']
    for youOrDax in ['you', 'dax']
      for responseShouldBeYes in [true, false]
        for numDotsOnLeftWall in [0..3]
          for numDotsOnRightWall in [0..3]
            if numDotsOnLeftWall+numDotsOnRightWall > 3
              continue
            theTrialSet = []
            theTrialSet.push createCross()
            if youOrDax is 'dax'
              theTrialSet.push createDAX()
            else
              theTrialSet.push createYOU()
          
            # work out which image to use
            if daxIsFacing is 'left'  
              imgName = "S0"
              daxSeesNum = numDotsOnLeftWall
            else
              imgName = "0S"
              daxSeesNum = numDotsOnRightWall
            imgName += "#{numDotsOnLeftWall}#{numDotsOnRightWall}.jpg"
            # console.log "/imgName #{imgName}"
          
            # work out which number to show
            if responseShouldBeYes
              if youOrDax is 'you'
                num =  numDotsOnLeftWall+numDotsOnRightWall
              else
                num = daxSeesNum
            else
              # response should be no
              if youOrDax is 'you'
                if daxSeesNum isnt numDotsOnLeftWall+numDotsOnRightWall
                  num = daxSeesNum
                else
                  # alternate between adding and removing one
                  if didPlusOneLastTime
                    num = (numDotsOnLeftWall+numDotsOnRightWall+3) %% 4
                  else
                    num = (numDotsOnLeftWall+numDotsOnRightWall+1) %% 4
                  didPlusOneLastTime = not didPlusOneLastTime
              else
                if daxSeesNum isnt numDotsOnLeftWall+numDotsOnRightWall
                  num = numDotsOnLeftWall+numDotsOnRightWall
                else
                  if didPlusOneLastTime
                    num = (daxSeesNum+3) %% 4
                  else
                    num = (daxSeesNum+1) %% 4
                  didPlusOneLastTime = not didPlusOneLastTime
            theTrialSet.push createNum(num)
          
            data = {
              youOrDax
              daxIsFacing
              numDotsOnLeftWall
              numDotsOnRightWall
              numParticipantVerifies : num
              responseShouldBeYes
              daxSeesNum
              imgName
              block : blockName
            }
            theTrialSet.push 
              type : 'single-stim'
              stimulus : "/img/samsonDax/stimuliPics-SkSa2016-E1/#{imgName}"
              choices : ['B','N']
              timing_response : 2000
              response_ends_trial : true
              data : data
              on_finish : (data) ->
                correct = false
                if data.responseShouldBeYes and data.key_press is 66 # 66 is B
                  correct = true
                if not data.responseShouldBeYes and data.key_press is 78 # 78 is N
                  correct = true
                jsPsych.data.addDataToLastTrial({responseIsCorrect: correct})
            
            # determine which collection of trials to add to ...
            if youOrDax is 'you'
              if responseShouldBeYes
                addToTrials = youYesTrials
              else
                addToTrials = youNoTrials
            else
              if responseShouldBeYes
                addToTrials = daxYesTrials
              else
                addToTrials = daxNoTrials
            addToTrials.push(theTrialSet)
  return {
    youYesTrials
    youNoTrials 
    daxYesTrials
    daxNoTrials 
  }
  
  
  
  

addToTimeline = (arrayOfArrayOfTrials) ->
  for arrayOfTrials in arrayOfArrayOfTrials
    for t in arrayOfTrials
      timeline.push t
  

forFamTrials = createAllTrials("FAMILIARIZATION_2")
famTrials = []
for index in [0..4]
  famTrials.push( forFamTrials.youYesTrials[index*4] )
  famTrials.push( forFamTrials.youNoTrials[index*4+1] )
  famTrials.push( forFamTrials.daxYesTrials[index*4+2] )
  famTrials.push( forFamTrials.daxNoTrials[index*4+3] )
# for some reason there should be 26 fam trials so let’s add six
famTrials.push( forFamTrials.youYesTrials[3] )
famTrials.push( forFamTrials.youYesTrials[15] )
famTrials.push( forFamTrials.youNoTrials[15] )
famTrials.push( forFamTrials.daxYesTrials[8] )
famTrials.push( forFamTrials.daxNoTrials[8] )
famTrials.push( forFamTrials.daxNoTrials[13] )
addToTimeline( jsPsych.randomization.repeat(famTrials, 1) )

# §ISSUE : instructions after familiarization weren’t specified so I made them up
timeline.push createInstructions([
  """
    <p>Nice! You’ve completed all of the practice and familiarization work.</p>
    <p>Next comes the main part of the experiment. </p>
    <p>(Do take a break here if you like.) </p>
  """
  """
    <p>There will be 4 test blocks. Between the blocks, you can take a break.</p>
    <p>Thanks again for your participation!</p>
    
    <p>Press the space bar to start the first test block ...</p>
  """
])


# §ISSUE : How many trials in each block of test trials? Which types of trial?
# I’ve assume each block contains one of each
# §ISSUE : instructions between trials weren’t specified so I made them up
for trialBlockNo in [1..4]
  testTrials = createAllTrials("TEST_#{trialBlockNo}")
  testTrialsRandomized = jsPsych.randomization.repeat(famTrials, 1)
  addToTimeline(testTrialsRandomized)
  if trialBlockNo < 3
    timeline.push createInstructions([
      """
        <p>Well done! You reached the end of test block #{trialBlockNo}.</p>
        <p>Do take a break here if you like.</p>
      """
      """
        <p>There are #{4-trialBlockNo} test blocks remaining.</p>
        <p>Press the space bar to start the next test block ...</p>
      """
    ])
    if trialBlockNo is 3
      timeline.push createInstructions([
        """
          <p>Well done! You reached the end of test block #{trialBlockNo}.</p>
          <p>Do take a break here if you like.</p>
        """
        """
          <p>There is just one test block remaining.</p>
          <p>Press the space bar to start the next test block ...</p>
        """
    ])
  
# §ISSUE : No instructions for debriefing specified, so I made something up.
timeline.push createInstructions([
  """
    <p>Well done! You reached the end of the whole experiment.</p>
    <p>Massive thanks for participating. Your contribution will help us to 
    understand how people track of perspectives, their own and others’.</p>
  """
  """
    <p>If you press the space bar again, you will be able to see all the 
    data we have collected about your participation.</p>
  """
])

# quick test : show only the first 10 trials
# timeline = timeline[..10]

# -------------------------------
# preload images and init jsPsych

# Compute the names of the 20 images for test trials
testImages = []
for daxIsFacing in ['left','right']
  for numDotsOnLeftWall in [0..3]
    for numDotsOnRightWall in [0..3]
      if numDotsOnLeftWall+numDotsOnRightWall > 3
        continue
      imgName = "/img/samsonDax/stimuliPics-SkSa2016-E1/"
      if daxIsFacing is 'left'  
        imgName += "S0"
      else
        imgName += "0S"
      imgName += "#{numDotsOnLeftWall}#{numDotsOnRightWall}.jpg"
      testImages.push(imgName)



imagesToPreload = [
  testImages...
  ("/img/samsonDax/Train_fam_full/Fam#{x}.jpg" for x in [1..22])...
  ("/img/samsonDax/Train_fam_full/FamP2_#{x}.jpg" for x in [1..3])...
  '/img/samsonDax/Train_fam_full/FamP2_10.jpg'
]



Template.App_samsonDax01.events
  'click #init-jspsych' : (event, instance) ->
    $('#init-jspsych').hide()
    $('#please-wait').show()
    console.log "imagesToPreload ..."
    console.log imagesToPreload
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
    

