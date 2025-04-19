#!/bin/bash

# Zahtevaj sudo
if [[ $EUID -ne 0 ]]; then
   echo "Pokreni ovu skriptu sa sudo privilegijama." 
   exit 1
fi

# Detektuj trenutni direktorijum (u kom je skripta pozvana)
BASE_DIR="$(pwd)"

# Lokacija gde se repozitorijum klonira
CLONE_DIR="$BASE_DIR/meshserbia-website"

# Lokacija gde ide public folder
TARGET_PUBLIC="$BASE_DIR/public"

# Obriši stari klon ako postoji
if [ -d "$CLONE_DIR" ]; then
    echo "Postoji prethodni 'meshserbia-website/', brišem..."
    rm -rf "$CLONE_DIR"
fi

# Kloniraj repo
git clone https://github.com/Sabering1/meshserbia-website.git "$CLONE_DIR" || {
    echo "Greška pri kloniranju repozitorijuma."
    exit 1
}

# Proveri da li postoji 'public' u kloniranom repou
if [ ! -d "$CLONE_DIR/public" ]; then
    echo "U repozitorijumu ne postoji folder 'public'."
    exit 1
fi

# Obriši postojeći public folder ako postoji
if [ -d "$TARGET_PUBLIC" ]; then
    echo "Postojeći public folder detektovan. Brišem: $TARGET_PUBLIC"
    rm -rf "$TARGET_PUBLIC"
fi

# Prebaci novi public folder
mv "$CLONE_DIR/public" "$TARGET_PUBLIC" || {
    echo "Ne mogu da premestim public folder."
    exit 1
}

# Obriši ceo kloniran repozitorijum
rm -rf "$CLONE_DIR"

# Build Docker imidž
docker build -t meshserbia-nginx "$BASE_DIR" || {
    echo "Docker build nije uspeo."
    exit 1
}

echo "Deploy završen uspešno."
