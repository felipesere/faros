exports.config = {
  files: {
    javascripts: {
      joinTo: 'js/app.js'
    },
    stylesheets: {
      joinTo: 'css/app.css'
    },
    templates: {
      joinTo: 'js/app.js'
    }
  },

  paths: {
    watched: [
      "deps/phoenix/web/static",
      "deps/phoenix_html/web/static",
      "web/static",
      "test/static",
      "web/elm"
    ],

    public: "priv/static"
  },

  plugins: {
    babel: {
      ignore: [/^(web\/static\/vendor)/]
    },

    elmBrunch: {
      mainModules: ['web/elm/Main.elm'],
    }
  }
};
