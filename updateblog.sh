#!/bin/bash
# redfishleo@gnayev.me

echo ----- Updating gnayev.me -----

# Avoid conflict to remote backup

echo ----- Purge Old Packages -----
rm -rf gnayevdot/

# Get latest depository
git clone git@github.com:redfish-lee/gnayevdot.git
cd gnayevdot/

# Link public/ to WWW
hugo

echo ------- Finish Updating ------
