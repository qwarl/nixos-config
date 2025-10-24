#!/usr/bin/env bash

SYMBOL="°C"
API_URL="https://api.open-meteo.com/v1/forecast"

# Lấy vị trí tự động qua IP (ipinfo.io)
loc=$(curl -sf "https://ipinfo.io/json")
IFS=',' read -r lat lon <<<"$(echo "$loc" | jq -r '.loc')"

if [ -z "$lat" ] || [ -z "$lon" ] || [ "$lat" = "null" ]; then
    echo "Location unavailable"
    exit 1
fi

# Lấy timezone từ ipinfo (nếu có)
tz=$(echo "$loc" | jq -r '.timezone')

# Gọi API Open-Meteo
weather=$(curl -sf "$API_URL?latitude=$lat&longitude=$lon&current_weather=true&temperature_unit=celsius&timezone=$tz")

if [ -n "$weather" ] && echo "$weather" | jq -e '.current_weather' >/dev/null 2>&1; then
    temp=$(echo "$weather" | jq '.current_weather.temperature' | cut -d. -f1)
    code=$(echo "$weather" | jq '.current_weather.weathercode')
    is_day=$(echo "$weather" | jq '.current_weather.is_day')

    case $code in
        0)  icon=$([ "$is_day" -eq 1 ] && echo "☀️" || echo "🌙");;
        1|2|3) icon="⛅";;
        45|48) icon="🌫️";;
        51|53|55|61|63|65|80|81|82) icon="🌧️";;
        56|57|66|67) icon="🌦️";;
        71|73|75|77|85|86) icon="❄️";;
        95|96|99) icon="⛈️";;
        *) icon="🌈";;
    esac

    echo "$temp$SYMBOL $icon"
else
    echo "Weather unavailable"
fi
