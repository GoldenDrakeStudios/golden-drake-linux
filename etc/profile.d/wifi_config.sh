#!/bin/bash
# To auto-connect the GDL installer to Wi-Fi, provide an SSID and password:

WIFI_SSID=""
WIFI_PASSWORD=""

if [[ -n "${WIFI_SSID}" && -n "${WIFI_PASSWORD}" ]]; then
  nmcli dev wifi connect "${WIFI_SSID}" password "${WIFI_PASSWORD}"
fi
