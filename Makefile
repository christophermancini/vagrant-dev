.PHONY: init

init:
	@rsync -aq Vagrantfile.template Vagrantfile
	@rsync -aq extra_vars.json.template extra_vars.json
