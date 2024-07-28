#!/bin/sh

#
# Title             : Kyle's SSH Webhook Alerts
# Description       : Notification Via Webhook For SSH Logins
# Author            : Kyle8973
# Date              : 04-01-2024
#===============================================================================

# Config {

        BOTNAME="YourServerName" #Name Of Webhook
        THUMBNAIL_URL="https://cdn-icons-png.flaticon.com/512/5261/5261867.png" #Thumbnail URL
        AVATAR_URL="https://icons.iconarchive.com/icons/blackvariant/button-ui-system-apps/512/Terminal-icon.png" #Bot Avatar / Footer Image
        WEBHOOK="" #Your-Webhook-URL
        DATE=$(date +"%d-%m-%Y-%H:%M:%S") #This Logs Date And Time

        TMPFILE=$(mktemp) #Creates A /tmp File Per SSH To Log The Request Data

# Embed Webhook Configuration

    IP=`echo $SSH_CLIENT | awk '{ ip = $1 } END { print ip }'`

    curl -s "https://ipapi.co/${IP}/json/" > $TMPFILE #Fetching User IP Data

    ISP=`cat $TMPFILE | jq .org | sed s/' '//g | sed s/'"'//g`

    #This Fetches The Connection Country - IN PROGRESS
    COUNTRY=`cat $TMPFILE | jq -r .country_name`

    #This Fetches The Connection City - IN PROGRESS
    CITY=`cat $TMPFILE | jq -r .city`

    #Date And Time
    getCurrentTimestamp() { date -u --iso-8601=seconds; };

    #Sends The Webhook	
        curl -i --silent \
        -H "Accept: application/json" \
        -H "Content-Type:application/json" \
        -X POST \
        --data  '{
            "username": "'"$BOTNAME"'",
            "avatar_url": "'"$AVATAR_URL"'",
            "embeds": [{
                "color": 12976176,
                "title": "SSH Login Detected",
                "thumbnail": { "url": "'"$THUMBNAIL_URL"'" },
                "author": { "name": "'"$BOTNAME"'", "icon_url": "'"$AVATAR_URL"'" },
                "footer": { "icon_url": "'"$AVATAR_URL"'", "text": "'"$BOTNAME"'" },
                "description": "**Details**\n \\👤 User: '\`$(whoami)\`' \n \\🖥️ Host: '\`$(hostname)\`' \n \\🕐 Time: '\`$DATE\`' \n\n **Connection IP**\n \\📡 IP: '\`${IP}\`'",
                "timestamp": "'$(getCurrentTimestamp)'"
            }]
        }' $WEBHOOK > /dev/null

#Checks The TMP File Before Deletion

checkdir() {
    if [ -e $TMPFILE ]; then
        rm -fr $TMPFILE
    else
        echo "$TMPFILE Not Found"
    fi
}
checkdir

#~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ }
