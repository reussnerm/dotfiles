#!/usr/bin/env bash

getRealName ()
{
	REALNAME=$(echo $1|cut -d '@' -f1|tr -d '-')
	REALNAME=$(grep "${REALNAME}\"" ${CACHE}/facebookFriend|cut -d '"' -f4)

	if [ "$REALNAME" == "" ]
	then
		REALNAME="John Doe(need to update friends list)"
	fi
}

getIcon ()
{
	local fbId=$(echo $JID|cut -d '@' -f1|tr -d '-')
	local sFb="$1"
	
	ICON="${CACHE}/${fbId}"
	if [ ! -f $ICON ]
	then
		wget -qO- "https://graph.facebook.com/${fbId}/picture" > $ICON
	fi
	case "$1" in
		"O") sFb="online.png"
			;;
		"F") sFb="chat.png"
			;;
		"A") sFb="away.png"
			;;
		"N") sFb="xa.png"
			;;
		"D") sFb="dnd.png"
			;;
		"I") sFb="invisible.png"
			;;
		"_") sFb="offline.png"
			;;
		"?") sFb="error.png"
			;;
		"X") sFb="requested.png"
			;;
		*) sFb="online.png"
			;;
	esac
	composite -gravity SouthEast ~/.config/awesome/naughtyicons/${sFb} $ICON ${CACHE}/${fbId}_display.png
	ICON="${CACHE}/${fbId}_display.png"
}

logNotification()
{
	echo "$(date '+%s'):$KIND:$JID:$STATUS" >> ~/.mcabber/status.log
}
