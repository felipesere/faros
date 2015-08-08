module.exports = function(config) {
  config.set({
    basePath: '',
    frameworks: ['jasmine', 'systemjs'],
    reporters: ['progress'],
    colors: true,
    browsers: ['PhantomJS'],
    singleRun: true,
    systemjs: {
      config: {
        baseURL: '',
        transpiler: 'babel',
        paths: {
          'babel': 'node_modules/babel-core/browser.js',
          'systemjs': 'node_modules/systemjs/dist/system.js',
          'system-polyfills': 'node_modules/systemjs/dist/system-polyfills.js',
          'es6-module-loader': 'node_modules/es6-module-loader/dist/es6-module-loader.js',
          'phantomjs-polyfill': 'node_modules/phantomjs-polyfill/bind-polyfill.js',
          'jasmine-fixture': 'node_modules/jasmine-fixture/dist/jasmine-fixture.min.js',
          'jasmine-jquery': 'node_modules/jasmine-jquery/lib/jasmine-jquery.js',
          'jquery': 'node_modules/jquery/dist/jquery.min.js'
        }
      },
      files: [
        'node_modules/jasmine-fixture/dist/jasmine-fixture.min.js',
        'node_modules/jasmine-jquery/lib/jasmine-jquery.js',
        'node_modules/jquery/dist/jquery.min.js',
        'web/static/js/**/*.js',
        'spec/**/*.js'
      ],
      testFileSuffix: '_spec.js'
    }
  });
};
