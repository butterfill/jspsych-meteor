import { FlowRouter } from 'meteor/kadira:flow-router';
import { BlazeLayout } from 'meteor/kadira:blaze-layout';
import { AccountsTemplates } from 'meteor/useraccounts:core'

// Import needed templates
import '../../ui/layouts/body/body.js';
import '../../ui/pages/home/home.js';
import '../../ui/pages/dataShow.coffee';
import '../../ui/pages/samsonDax/samsonDax01.coffee';
import '../../ui/pages/samsonDax/abandonedGoalsAdults.coffee';
import '../../ui/pages/abandonedGoalsAdultsResults.coffee';
import '../../ui/pages/samsonDax/mentalStateAttribution.coffee';
import '../../ui/pages/samsonDax/samsonDaxShowData.coffee';
import '../../ui/pages/auth/auth.js';
import '../../ui/pages/not-found/not-found.js';

// Set up all routes in the app
FlowRouter.route('/', {
  name: 'App.home',
  action() {
    BlazeLayout.render('App_body', { main: 'App_home' })
  }
})


FlowRouter.route('/test', {
  triggersEnter: [AccountsTemplates.ensureSignedIn],
  name: 'App.home',
  action() {
    BlazeLayout.render('App_body', { main: 'App_test' });
  }
})

FlowRouter.route('/saveData', {
  triggersEnter: [AccountsTemplates.ensureSignedIn],
  name : 'saveData',
  action : function(params, queryParams) {
    console.log("Params:", params);
    console.log("Query Params:", queryParams);
  }
})

FlowRouter.route('/e1', {
  action(params, queryParams) {
    BlazeLayout.render('App_e1')
  }
})

FlowRouter.route('/e/:_experimentName', {
  action(params, queryParams) {
    console.log('App_'+params._experimentName)
    BlazeLayout.render('App_body_experiment', { main: 'App_'+params._experimentName })
  }
})

FlowRouter.route('/e/:_experimentName/results', {
  action(params, queryParams) {
    console.log('App_'+params._experimentName+'Results')
    BlazeLayout.render('App_body_experiment', { main: 'App_'+params._experimentName+'Results' })
  }
})

FlowRouter.route('/d/samsonDaxShowData', {
  triggersEnter: [AccountsTemplates.ensureSignedIn],
  name: 'App.samsonDaxShowData',
  action() {
    BlazeLayout.render('App_body', { main: 'App_samsonDaxShowData' });
  }
})

FlowRouter.route('/d/:_experimentName', {
  triggersEnter: [AccountsTemplates.ensureSignedIn],
  action() {
    BlazeLayout.render('App_body', { main: 'dataShow' })
  }
})
FlowRouter.route('/d/:_experimentName/csv/:_id', {
  triggersEnter: [AccountsTemplates.ensureSignedIn],
  action() {
    BlazeLayout.render('App_body', { main: 'dataShowCSV' })
  }
})
FlowRouter.route('/d/:_experimentName/json/:_id', {
  triggersEnter: [AccountsTemplates.ensureSignedIn],
  action() {
    BlazeLayout.render('App_body', { main: 'dataShowJSON' })
  }
})
FlowRouter.route('/d/:_experimentName/all_json', {
  triggersEnter: [AccountsTemplates.ensureSignedIn],
  action() {
    BlazeLayout.render('App_body', { main: 'dataShowAllJSON' })
  }
})

FlowRouter.notFound = {
  action() {
    BlazeLayout.render('App_body', { main: 'App_notFound' })
  }
}
