if [ ${SSID} ] && [ ${PASSWORD} ]; then
    nmcli dev wifi connect "${SSID}" password "${PASSWORD}"
fi
