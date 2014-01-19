module.exports = (grunt) ->
	grunt.initConfig
		pkg: grunt.file.readJSON('package.json')
		sass:
			app:
				files:
					'app/css/screen.css': 'sass/screen.scss'
					'app/css/ie.css': 'sass/ie.scss'
		coffee:
			compile:
				files:
					'app/js/script.js': 'coffee/*.coffee'
		jshint:
			options:
				smarttabs: true
			all: [
				# 'app/js/*.js'
				# '!app/js/*.min.js'
				'app/js/script.js'
			]
			# gruntfile: [
			# 	'Gruntfile.js'
			# ]
		uglify:
			app:
				files:
					'app/js/script.min.js': [
						'app/js/script.js'
					]
			libs:
				files:
					'app/js/libs.min.js': [
						'bower_components/angular/angular.js'
						'bower_components/angular-route/angular-route.js'
						'bower_components/jQuery/index.js'
					]
					'app/js/libs-ie.min.js': [
						'bower_components/html5shiv/dist/html5shiv.js'
						'bower_components/respond/dest/respond.matchmedia.addListener.src.js'
					]
		watch:
			sass:
				files: ['sass/**/*.scss']
				tasks: ['sass']
				options:
					livereload: true
			coffee:
				files: ['coffee/*.coffee']
				tasks: ['coffee']
			js:
				files: ['app/js/*.js', '!app/js/*.min.js']
				tasks: ['jshint', 'uglify:app']
				options:
					livereload: true
			html:
				files: ['app/**/*.html']
				options:
					livereload: true
			# gruntfile:
			# 	files: 'Gruntfile.coffee'
			# 	tasks: ['jshint:gruntfile']
			# options:
			# 	livereload: true
		connect:
			server:
				options:
					port: 9111
					base: 'app'
					livereload: true

	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-contrib-sass'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-jshint'
	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-contrib-connect'

	grunt.registerTask 'build', ['sass', 'coffee', 'jshint', 'uglify:app']
	grunt.registerTask 'build:libs', ['build', 'uglify:libs']
	grunt.registerTask 'default', ['build', 'connect', 'watch']
