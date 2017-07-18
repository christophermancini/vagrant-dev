.PHONY: init

init:
	@rsync -aq template.Vagrantfile Vagrantfile
	@rsync -aq template.extra_vars.json extra_vars.json
