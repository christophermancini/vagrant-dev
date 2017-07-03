#!/bin/bash

# install EPEL repo and allow deltarpms to save bandwidth
python -mplatform | grep -i centos && sudo yum -y install epel-release deltarpm

# install all updates except kernel updates which can create compatability problems with VBox Guest Additions
python -mplatform | grep -iE 'Ubuntu|debian' && sudo apt-get update -y || sudo yum -y -x 'kernel*' update

if [[ "$VAGRANT_DEV_ANSIBLE" == "false" ]]
then
    printf 'SKIPPING ANSIBLE INSTALL\n'
    exit 0
fi

printf '
    ######################################################################################
    ##                                                                                  ##
    ##                             Installing Ansible                                   ##
    ##                                                                                  ##
    ## While you wait, learn about Ansible: http://docs.ansible.com/                    ##
    ##                                                                                  ##
    ######################################################################################\n'

python -mplatform | grep -iE 'Ubuntu|debian' && sudo apt-get install -y aptitude libffi-dev git python-pip python-dev || sudo yum install -y libselinux-python libffi-devel gcc openssl-devel git python-pip python-devel

# ssl workaround for Python < 2.7.8
python --version | grep -iE '2.7.[0-8]' && sudo pip install urllib3 pyOpenSSL ndg-httpsclient pyasn1
curl https://bootstrap.pypa.io/get-pip.py | sudo python

python --version
pip --version

sudo pip install ansible --no-cache

# install galaxy role dependencies
sudo ansible-galaxy install -fr /vagrant/provisioning/requirements.yml

# ensure ansible dir exists
if [ ! -d /etc/ansible ]; then
    mkdir -p /etc/ansible;
fi

# setup the local machine as the ansible host
if [[ "$VAGRANT_DEV_BOX" ]]
then
    echo "${VAGRANT_DEV_BOX}.vagrant-dev" | sudo tee -a /etc/ansible/hosts

    # if main, append other local guests remote provisioning
    if [[ "$VAGRANT_DEV_BOX" == "main" ]]
    then
        echo "ansible.vagrant-dev" | sudo tee -a /etc/ansible/hosts
    fi
fi

if [[ "$VAGRANT_DEV_VERBOSE" != "false" ]]
then
    printf "
    ######################################################################################
    ##                                                                                  ##
    ##             Executing Ansible playbook, please be patient...                     ##
    ##                                                                                  ##
    ######################################################################################\n"

    ansible-playbook /vagrant/provisioning/playbook.${VAGRANT_DEV_BOX}.yml -v --extra-vars="${1}"

    printf '
    ######################################################################################
    ##                                                                                  ##
    ##                          Provisioning complete!                                  ##
    ##                                                                                  ##
    ## Useful commands:                                                                 ##
    ##   - `vagrant ssh` login to your VM via ssh                                       ##
    ##   - `vagrant provision` rerun this provisioner                                   ##
    ##                                                                                  ##
    ## If you see errors above:                                                         ##
    ##   - Try vagrant destroy, then vagrant up again                                   ##
    ##   - If you cannot resolve it, please copy / pasta the error to a GitHub Issue    ##
    ##                                                                                  ##
    ##                                                                                  ##
    ######################################################################################

    If you need to run the playbook manually, use:
    \t`sudo ansible-playbook /vagrant/provisioning/%s.yml -v --extra-vars="%s"`
    ' ${VAGRANT_DEV_BOX} "${1}"
else
    ansible-playbook /vagrant/provisioning/playbook.${VAGRANT_DEV_BOX}.yml --extra-vars="${1}"
fi
