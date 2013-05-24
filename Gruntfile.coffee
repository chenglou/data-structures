module.exports = (grunt) ->

    grunt.initConfig
        package: grunt.file.readJSON 'package.json'
        outputFileName: '<%= package.name %>-<%= package.version %>'

        clean:
            before: ['distribution/*']
            after: ['distribution/temp']

        coffee:
            all:
                expand: yes
                cwd: 'source/'
                src: ['*.coffee']
                dest: 'distribution/temp'
                ext: '.js'

        browserify2:
            compile:
                options:
                    expose:
                        'data-structures': './distribution/temp/index.js'
                entry: './distribution/temp/index.js'
                compile: 'distribution/<%= outputFileName %>.js'

        uglify:
            'distribution/<%= outputFileName %>.min.js': ['distribution/<%= outputFileName %>.js']

    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-browserify2'
    grunt.loadNpmTasks 'grunt-contrib-uglify'

    grunt.registerTask 'default', ['clean:before', 'coffee', 'browserify2', 'uglify', 'clean:after']
