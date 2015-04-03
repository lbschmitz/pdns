#!/bin/bash
cat <<EOF | sudo tee /etc/apt/preferences.d/vivid-manual-only
Package: *
Pin: release n=vivid
Pin-Priority: 99
EOF

grep '\sutopic\s' /etc/apt/sources.list | sudo tee /etc/apt/sources.list.d/vivid.list
sudo sed 's/utopic/vivid/g' -i /etc/apt/sources.list.d/vivid.list
