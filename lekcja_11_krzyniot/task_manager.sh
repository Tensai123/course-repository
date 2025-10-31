#!/bin/bash
# ===============================================
#  Lekcja 11: Bash - Zadanie 3 (ekspert)
#  Terminalowy menedżer zadań z zapisem do CSV
# ===============================================

TASK_FILE="tasks.csv"

# --- Funkcja inicjalizacji ---
init_file() {
    if [[ ! -f "$TASK_FILE" ]]; then
        echo "ID;Tytuł;Priorytet;Status" > "$TASK_FILE"
        echo "✅ Utworzono plik z zadaniami: $TASK_FILE"
    fi
}

# --- Funkcja wyświetlania menu ---
show_menu() {
    echo
    echo "🧭 MENU:"
    echo "1. ➕ Dodaj zadanie"
    echo "2. 📋 Wyświetl zadania"
    echo "3. 🗑️  Usuń zadanie"
    echo "4. 🔎 Filtruj po priorytecie"
    echo "5. ❌ Zakończ"
    echo
}

# --- Dodawanie zadania ---
add_task() {
    read -p "Tytuł zadania: " title
    read -p "Priorytet (niski/średni/wysoki): " priority
    id=$(( $(wc -l < "$TASK_FILE") ))
    echo "$id;$title;$priority;Nowe" >> "$TASK_FILE"
    echo "✅ Zadanie dodane!"
}

# --- Wyświetlanie wszystkich zadań ---
list_tasks() {
    echo "📋 Lista zadań:"
    column -s ";" -t < "$TASK_FILE"
}

# --- Usuwanie zadania po ID ---
delete_task() {
    read -p "Podaj ID zadania do usunięcia: " id
    grep -v "^$id;" "$TASK_FILE" > tmpfile && mv tmpfile "$TASK_FILE"
    echo "🗑️ Zadanie o ID $id usunięte!"
}

# --- Filtrowanie po priorytecie ---
filter_tasks() {
    read -p "Podaj priorytet (niski/średni/wysoki): " p
    echo "🔍 Zadania o priorytecie: $p"
    grep -i ";$p;" "$TASK_FILE" | column -s ";" -t
}

# --- Główna pętla programu ---
init_file

while true; do
    show_menu
    read -p "Wybierz opcję [1-5]: " choice
    case $choice in
        1) add_task ;;
        2) list_tasks ;;
        3) delete_task ;;
        4) filter_tasks ;;
        5) echo "👋 Zakończono."; break ;;
        *) echo "❗ Nieprawidłowa opcja." ;;
    esac
done
