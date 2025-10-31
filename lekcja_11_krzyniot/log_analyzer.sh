#!/bin/bash
# ===============================================
#  Lekcja 11: Bash - Zadanie 2
#  Skrypt do analizy logów i raportu CSV
# ===============================================

# Użycie
usage() {
    echo "Użycie: $0 <plik_logu>"
    echo "Przykład: $0 /var/log/syslog"
    exit 1
}

# --- Sprawdzenie argumentu ---
if [[ $# -eq 0 ]]; then
    usage
fi

logfile="$1"

if [[ ! -f "$logfile" ]]; then
    echo "❌ Plik $logfile nie istnieje!"
    exit 1
fi

# --- Zliczanie błędów ---
echo "🔍 Analiza pliku logów: $logfile"

# Szukamy linii zawierających słowo ERROR lub Error (bez rozróżniania wielkości liter)
error_count=$(grep -i "error" "$logfile" | wc -l)

if [[ $error_count -eq 0 ]]; then
    echo "✅ Nie znaleziono błędów w logu."
    exit 0
fi

echo "🚨 Znaleziono $error_count linii z błędami."

# --- Znalezienie 10 najczęstszych błędów ---
echo "📊 Najczęstsze błędy:"
grep -i "error" "$logfile" \
  | awk '{for(i=1;i<=NF;i++) if(tolower($i)~/error/) print $0}' \
  | sort \
  | uniq -c \
  | sort -nr \
  | head -10

# --- Zapis do CSV ---
report_file="log_report_$(date +%Y-%m-%d_%H-%M-%S).csv"

echo "Wiadomość błędu;Ilość wystąpień" > "$report_file"
grep -i "error" "$logfile" \
  | awk '{for(i=1;i<=NF;i++) if(tolower($i)~/error/) print $0}' \
  | sort \
  | uniq -c \
  | sort -nr \
  | head -10 \
  | awk '{count=$1; $1=""; sub(/^ /, ""); msg=$0; gsub(/;/, ",", msg); print "\"" msg "\";" count}' >> "$report_file"

echo "💾 Raport zapisany do: $report_file"
