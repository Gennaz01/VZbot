#!/bin/bash
cd /home/pi/klipper-backup || exit 1
git add -A
git commit -m "${1:-Backup $(date +'%Y-%m-%d %H:%M')}"
git push origin main
