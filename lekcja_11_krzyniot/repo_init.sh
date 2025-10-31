#!/bin/bash

# 🧰 Sprawdzenie, czy podano nazwę projektu
if [ -z "$1" ]; then
  echo "❌ Użycie: ./repo_init.sh <nazwa_projektu>"
  exit 1
fi

PROJECT_NAME=$1

echo "🚀 Tworzenie nowego projektu: $PROJECT_NAME"

# 📁 Tworzenie katalogu projektu
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME" || exit

# 📝 Tworzenie pliku README.md
echo "# Projekt $PROJECT_NAME" > README.md

# 🌀 Inicjalizacja repozytorium Git
git init -q
git add .
git commit -m "Initial commit – projekt $PROJECT_NAME" > /dev/null

echo "✅ Repozytorium $PROJECT_NAME zostało utworzone!"
echo "📂 Struktura:"
tree .
