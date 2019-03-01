import { Accounts } from 'meteor/accounts-base';
import { AccountsTemplates } from 'meteor/useraccounts:core'

// Accounts.ui.config({
//   passwordSignupFields: 'USERNAME_ONLY',
// });

AccountsTemplates.configure({
  defaultTemplate: 'Auth_page',
  defaultLayout: 'App_body',
  defaultContentRegion: 'main',
  defaultLayoutRegions: {},
  enablePasswordChange : true
  // showForgotPasswordLink: false
});

AccountsTemplates.configureRoute('signIn')
AccountsTemplates.configureRoute('signUp')
AccountsTemplates.configureRoute('changePwd')

// # See https://github.com/meteor-useraccounts/flow-routing
// FlowRouter.triggers.enter(   
//   [AccountsTemplates.ensureSignedIn],
//   {
//     except: [ 
//       'signIn',
//       'signUp',
//       'forgotPwd',
//       'resetPwd',
//       'verifyEmail',
//       'resendVerificationEmail',
//       'termsOfUse',
//       'saveData'
//     ]
//   }
// ); 