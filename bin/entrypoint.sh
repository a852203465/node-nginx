#!/usr/bin/env bash

echo "Starting entrypoint.sh..."

set -e

if ! test -d "/etc/nginx/html"; then
    mv /usr/share/nginx/html /etc/nginx
fi

sed -i "s|<body>|<body>\n<script src="./industry_config.js"></script>|g" /etc/nginx/html/index.html

envs=$(printenv)
json="{ "
while IFS= read -r line; do
  env_name=$(echo $line | cut -d "=" -f1)
  env_value=$(echo $line | cut -d "=" -f2)
  json=$json"\"$env_name\": \"$env_value\", "
done <<< "$envs"
json="${json%,} }"

echo "env: $json"

config="Object.defineProperty(window, 'industry_config',{get: function(){return Object.seal(${json})},configurable: false,})"
echo $config > /etc/nginx/html/industry_config.js

echo "Starting nginx in the background..."
nginx -g "daemon off;"
