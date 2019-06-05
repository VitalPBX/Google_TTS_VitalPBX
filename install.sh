#!/bin/bash
set -e
# Authors:      Rodrigo Cuadra
#               with Collaboration of Jose Miguel Rivera
#
# Support:      rcuadra@vitalpbx.com
#
echo -e "\n"
echo -e "************************************************************"
echo -e "*      Welcome to the VitalPBX Google TTS Integration      *"
echo -e "************************************************************"
yum install -y perl perl-LWP-Protocol-https mpg123 sox perl-libwww-perl
cd /var/lib/asterisk/agi-bin/
wget https://raw.githubusercontent.com/VitalPBX/Google_TTS_VitalPBX/master/googletts.agi
chown asterisk:asterisk googletts.agi
chmod +x googletts.agi
cd /etc/asterisk/ombutel
wget https://raw.githubusercontent.com/VitalPBX/Google_TTS_VitalPBX/master/extensions__60-google_tts.conf
asterisk -rx"dialplan reload"
echo -e "\n"
echo -e "************************************************************"
echo -e "*              For test dial *887 or *8870                 *"
echo -e "************************************************************"
