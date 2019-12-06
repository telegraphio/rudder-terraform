#!/bin/bash

# Fetch rudder-server binary
echo "Fetching latest Linux_x86_64 release of rudder-server"
LATEST_SERVER_RELEASE=$(basename $(curl -Ls -o /dev/null -w %{url_effective} https://github.com/rudderlabs/rudder-server/releases/latest))
echo "Latest rudder-server release is ${LATEST_SERVER_RELEASE}"

mkdir rudder-server-tmp
curl -s https://api.github.com/repos/rudderlabs/rudder-server/releases/latest \
| grep "browser_download_url.*_Linux_x86_64.tar.gz" \
| cut -d : -f 2,3 \
| tr -d \" \
| xargs curl -sL \
| tar xz -C rudder-server-tmp

mv rudder-server-tmp/rudder-server rudder-server
rm -r rudder-server-tmp

echo -e "Downloaded and extracted rudder-server ${LATEST_SERVER_RELEASE}\n"

# Fetch rudder-transformer zip (will be unarchived on remote)
echo "Fetching latest release of rudder-transformer"
LATEST_TRANSFORMER_RELEASE=$(basename $(curl -Ls -o /dev/null -w %{url_effective} https://github.com/rudderlabs/rudder-transformer/releases/latest))
echo "Latest rudder-transformer release is ${LATEST_TRANSFORMER_RELEASE}"

curl -s https://api.github.com/repos/rudderlabs/rudder-transformer/releases/latest \
| grep "zipball_url.*" \
| cut -d : -f 2,3 \
| tr -d \" \
| xargs curl -Lo rudder-transformer.zip

echo -e "Downloaded rudder-transformer ${LATEST_TRANSFORMER_RELEASE}\n"