
#!/usr/bin/env bash

#Check for root run
uid=$(id -u)
[ $uid -ne 0 ] && { echo "ERROR: MediaInstaller must be run as root. Try adding 'sudo' before your command."; exit 1;}

#install essentials
apt-get install -y vim git-core python-cheetah curl apache2;

#VARS
INSTALLDIR=/$USER/repos

#Base setup
# make our dir if it doesn't exits
if [ ! -d "$INSTALLDIR" ]; then
	mkdir $INSTALLDIR
fi
cd $INSTALLDIR;

#get and install couchpotato
if [ ! -d "$INSTALLDIR/CouchPotatoServer" ];then
	git clone https://github.com/CouchPotato/CouchPotatoServer.git;
else
	git -C $INSTALLDIR/CouchPotatoServer pull;
fi
cp CouchPotatoServer/init/ubuntu /etc/init.d/couchpotato;
echo "CP_HOME=$INSTALLDIR/CouchPotatoServer" > /etc/default/couchpotato;
echo "CP_USER=root" >> /etc/default/couchpotato;
chmod +x /etc/init.d/couchpotato;
update-rc.d couchpotato defaults;

##get and install sickbeard
if [ ! -d "$INSTALLDIR/SickBeard" ];then
	git clone git://github.com/midgetspy/Sick-Beard.git SickBeard;
else
	git -C $INSTALLDIR/SickBeard pull;
fi
cp SickBeard/init.ubuntu /etc/init.d/sickbeard;
echo "SB_HOME=$INSTALLDIR/SickBeard" > /etc/default/sickbeard;
echo "SB_USER=root" >> /etc/default/sickbeard;
chmod +x /etc/init.d/sickbeard;
update-rc.d sickbeard defaults;
cp $INSTALLDIR/SickBeard/autoProcessTV/autoProcessTV.cfg.sample $INSTALLDIR/SickBeard/autoProcessTV/autoProcessTV.cfg;


#get and install sabnzbd+
apt-get install -y sabnzbdplus;
echo "USER=root" > /etc/default/sabnzbdplus;
echo "HOST=0.0.0.0" >> /etc/default/sabnzbdplus;
echo "PORT=8082" >> /etc/default/sabnzbdplus;
chkconfig sabnzbdplus on;

#get and install plex
curl http://shell.ninthgate.se/packages/shell-ninthgate-se-keyring.key | apt-key add -;
echo "deb http://shell.ninthgate.se/packages/debian wheezy main" > /etc/apt/sources.list.d/plex.list;
apt-get update && apt-get install -y plexmediaserver;
