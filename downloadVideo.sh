#!/bin/bash

# Controllo se youtube-dl è installato
if ! command -v youtube-dl &> /dev/null; then
    echo "youtube-dl non è installato. Installalo con 'brew install youtube-dl' (richiede Homebrew)."
    exit 1
fi

# Controllo se la cartella "download" esiste, altrimenti la crea
if [ ! -d "download" ]; then
    mkdir "download"
fi

# Richiesta del numero di link in input
read -p "Inserisci il numero di link da scaricare: " num_links

# Richiesta dei link dei video YouTube
read -p "Inserisci i link dei video YouTube separati da virgole: " links

# Dividi i link in un array
IFS="," read -ra links_array <<< "$links"

# Scarica l'audio MP3 dai video YouTube
for ((i=0; i<num_links; i++)); do
    youtube-dl --extract-audio --audio-format mp3 -o "download/%(title)s.%(ext)s" "${links_array[i]}"
done
