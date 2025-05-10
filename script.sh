#!/bin/bash

export KLIPPER_CONFIG_DIR="/home/pi/printer_data/config"
BACKUP_DIR="/home/pi/klipper-backup"

echo "KLIPPER_CONFIG_DIR is: $KLIPPER_CONFIG_DIR"
echo "BACKUP_DIR is: $BACKUP_DIR"

# Copia i file dal config alla cartella di backup, escludendo .git
rsync -av --delete --exclude='.git' "$KLIPPER_CONFIG_DIR/" "$BACKUP_DIR/"

# Entra nella cartella git
cd "$BACKUP_DIR" || exit 1

# Commit e push dei cambiamenti
git add .
git commit -m "Backup automatico $(date '+%Y-%m-%d %H:%M:%S')" || echo "Nessuna modifica da salvare"
git push


