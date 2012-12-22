#!/bin/sh
MODULES_PATH="$HOME/.mcabber/modules"
KIND=$(echo $1 | sed -e "s/'/_/g")
JID=$(echo $3 | sed -e "s/'/_/g")
STATUS=$2
FILE_CHAT=$4
DOMAIN=$(echo $JID|cut -d '@' -f2)
CACHE="${HOME}/.mcabber/cache"


if [ ! -f "${MODULES_PATH}/${DOMAIN}" ]
then
	DOMAIN="default"
fi
source "${MODULES_PATH}/${DOMAIN}"

getRealName $JID
getIcon $STATUS
logNotification 

echo "mcabber_event_hook('$KIND', '$STATUS', '${REALNAME}', '$FILE_CHAT', '$ICON', 'facebook')" | awesome-client
#echo ~/.mcabber/event.sh $* >> ~/.mcabber/foo
