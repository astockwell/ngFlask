all:
	@bundle install
	@bourbon install --path sass/framework
	@cd sass/framework; neat install; cd ../../
	@bower install
	@npm install
	@grunt build:libs

