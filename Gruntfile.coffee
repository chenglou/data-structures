module.exports = (grunt) ->

  grunt.initConfig
    package: grunt.file.readJSON 'package.json'
    outputFileName: '<%= package.name %>-<%= package.version %>'

    coffeelint:
      all:
        src: ['source/*.coffee', 'tests/*.coffee']

    clean:
      all: ['distribution/*']

    coffee:
      all:
        expand: yes
        cwd: 'source/'
        src: ['*.coffee']
        dest: 'distribution/'
        ext: '.js'

    jasmine_node:
        projectRoot: '.'
        source: './source'
        specFolders: [ './tests' ]
        specNameMatcher: 'spec'
        extensions: 'coffee'
        useCoffee: true
        forceExit: false
        jUnit:
            report: false
            savePath: './reports/jasmine/'
            useDotNotation: true
            consolidate: true

    browserify2:
      compile:
        options:
          expose:
            'data-structures': './distribution/index.js'
        entry: './distribution/index.js'
        compile: 'distribution/browser/<%= outputFileName %>.js'

    uglify:
      all:
        src: ['distribution/browser/<%= outputFileName %>.js']
        dest: 'distribution/browser/<%= outputFileName %>.min.js'

  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-browserify2'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-jasmine-node'

  grunt.registerTask 'test', [ 'jasmine_node' ]

  grunt.registerTask 'default', ['coffeelint', 'clean', 'coffee',
                                 'test', 'browserify2', 'uglify']
