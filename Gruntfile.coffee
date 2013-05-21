module.exports = (grunt) ->

    grunt.initConfig
        package: grunt.file.readJSON 'package.json'
        outputFileName: '<%= package.name %>-<%= package.version %>'

        clean:
            before: ['distribution/*']
            after: ['distribution/source', 'distribution/index.js']

        coffee:
            index:
                files:
                    'distribution/index.js': ['index.coffee']
            modules:
                expand: yes
                cwd: 'source/'
                src: ['*.coffee']
                dest: 'distribution/source'
                ext: '.js'

        browserify2:
            compile:
                options:
                    expose:
                        'data-structures': './distribution/index.js'
                entry: './distribution/index.js'
                compile: 'distribution/<%= outputFileName %>.js'

        uglify:
            'distribution/<%= outputFileName %>.min.js': ['distribution/<%= outputFileName %>.js']

    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-browserify2'
    grunt.loadNpmTasks 'grunt-contrib-uglify'

    grunt.registerTask 'default', ['clean:before', 'coffee', 'browserify2', 'uglify', 'clean:after']
