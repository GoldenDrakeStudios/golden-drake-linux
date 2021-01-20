# To autoconnect the installer to Wi-Fi, uncomment and define these variables:

#SSID="wifi_network_ssid"
#PASSWORD="wifi_network_password"

if [ ${SSID} ] && [ ${PASSWORD} ]; then
  nmcli dev wifi connect "${SSID}" password "${PASSWORD}"
fi
