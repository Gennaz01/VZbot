#!/bin/bash

export KLIPPER_CONFIG_DIR="/home/pi/printer_data/config"
BACKUP_DIR="/home/pi/klipper-backup"
GIT_REMOTE_URL="https://github.com/Gennaz01/VZbot.git"  # Sostituisci con il tuo URL del repository

echo "KLIPPER_CONFIG_DIR is: $KLIPPER_CONFIG_DIR"
echo "BACKUP_DIR is: $BACKUP_DIR"

# Copia i file dal config alla cartella di backup, escludendo .git
rsync -av --delete --exclude='.git' "$KLIPPER_CONFIG_DIR/" "$BACKUP_DIR/"

# Entra nella cartella di backup
cd "$BACKUP_DIR" || exit 1

# Verifica se è un repository git
if [ ! -d ".git" ]; then
  echo "⚠️  Questa cartella non è un repository git. Inizializzo il repository e aggiungo il remote."

  # Inizializza il repository e aggiungi il remote
  git init
  git remote add origin "$GIT_REMOTE_URL"

  # Imposta la branch main come branch di default
  git checkout -b main
fi

# Commit e push dei cambiamenti
git add .
git commit -m "Backup automatico $(date '+%Y-%m-%d %H:%M:%S')" || echo "Nessuna modifica da salvare"
git push -u origin main


