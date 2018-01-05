module.exports = {
  servers: {
    one: {
      // TODO: set host address, username, and authentication method
      host: '85.255.15.169',
      username: 'root',
      pem: "~/.ssh/id_rsa"
      
    }
  },
  app: {
    // TODO: change app name and path
    name: 'experiment1',
    path: '../',

    servers: {
      one: {},
    },

    buildOptions: {
      serverOnly: true,
    },

    env: {
      ROOT_URL: 'http://85.255.15.169:3000',
      MONGO_URL: 'mongodb://localhost/meteor',
      PORT: 3000
    },

    // ssl: { // (optional)
    //   // Enables let's encrypt (optional)
    //   autogenerate: {
    //     email: 'email.address@domain.com',
    //     // comma separated list of domains
    //     domains: 'website.com,www.website.com'
    //   }
    // },

    docker: {
      // change to 'abernix/meteord:base' if your app is using Meteor 1.4 - 1.5
      image: 'abernix/meteord:node-8.4.0-base',
    },

    // Show progress bar while uploading bundle to server
    // You might need to disable it on CI servers
    enableUploadProgressBar: true
  },

  mongo: {
    version: '3.4.1',
    servers: {
      one: {}
    }
  }
};
