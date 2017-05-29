#!/bin/bash

# need to have xcode installed, opened and agreement accepted.
# and command line tools.
# TODO: write script to install command line tools

# install ansible
sudo easy_install pip
sudo pip install ansible --quiet

# to run ansible:
# $ ansible-playbook local/local.yml --ask-sudo-pass
