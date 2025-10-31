#!/bin/bash
# ===============================================
#  Lekcja 11: Bash - Zadanie 1
#  Rozszerzony skrypt tworzenia projektu
# ===============================================

# Użycie
usage() {
    echo "Użycie: $0 <nazwa_projektu> [katalog1 katalog2 ...] [--no-readme]"
    echo "Przykład: $0 myApp src tests docs --no-readme"
    exit 1
}

# Sprawdzenie, czy podano nazwę projektu
if [[ $# -eq 0 ]]; then
    usage
fi

project_name="$1"
shift

# Domyślne katalogi
base_dirs=("src" "tests" "docs" "config")
create_readme=true

# Przetwarzanie argumentów
for arg in "$@"; do
    if [[ "$arg" == "--no-readme" ]]; then
        create_readme=false
    else
        base_dirs+=("$arg")
    fi
done

# Funkcja do bezpiecznego tworzenia katalogów
create_dir() {
    local dir="$1"
    if [[ -d "$dir" ]]; then
        echo "⚠️  Katalog $dir już istnieje"
        return 1
    fi

    if mkdir -p "$dir"; then
        echo "✅  Utworzono katalog $dir"
        return 0
    else
        echo "❌  Błąd przy tworzeniu $dir"
        return 1
    fi
}

# Funkcja tworząca README.md
create_readme_file() {
    local project="$1"
    cat > "$project/README.md" << EOF
# $project

## O projekcie
Krótki opis projektu.

## Struktura katalogów
$(for dir in "${base_dirs[@]}"; do echo "- \`$dir/\`"; done)

## Instalacja
\`\`\`bash
git clone ...
cd $project
\`\`\`
EOF
    echo "✅  Utworzono README.md"
}

# Główna część
echo "🚀  Tworzenie projektu: $project_name"

if ! create_dir "$project_name"; then
    echo "❌  Nie można utworzyć projektu"
    exit 1
fi

for dir in "${base_dirs[@]}"; do
    create_dir "$project_name/$dir"
done

if $create_readme; then
    create_readme_file "$project_name"
else
    echo "📄  Pominięto tworzenie README.md"
fi

# Inicjalizacja repozytorium Git (jeśli dostępny)
if command -v git &>/dev/null; then
    (
        cd "$project_name" && git init >/dev/null && echo "🌀  Zainicjalizowano repozytorium Git"
    )
else
    echo "⚠️  Git nie jest zainstalowany, pomijam inicjalizację"
fi

echo "✨  Projekt $project_name został pomyślnie utworzony!"
