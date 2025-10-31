# Lekcja 11 – Automatyzacja w Bashu i analiza danych

Autor: **krzyniot**

---

## 🎯 Cel lekcji

Celem zadania było stworzenie zestawu trzech praktycznych skryptów w Bashu, które automatyzują procesy programistyczne, analizują dane systemowe i zarządzają zadaniami z poziomu terminala.

---

## 🧰 Zawartość folderu

| Plik | Opis |
|------|------|
| `project_setup.sh` | Automatycznie tworzy strukturę projektu (foldery, pliki, repozytorium Git). |
| `log_analyzer.sh` | Analizuje pliki logów systemowych (`/var/log/syslog`) i generuje raport CSV z najczęstszymi błędami. |
| `task_manager.sh` | Prosty terminalowy menedżer zadań (TODO) zapisujący dane w pliku `tasks.csv`. |

---

## ⚙️ Instrukcja użycia

### 1. `project_setup.sh`
Tworzy kompletną strukturę projektu i inicjuje repozytorium Git.

```bash
chmod +x project_setup.sh
./project_setup.sh mojProjekt
./project_setup.sh blog src assets config --no-readme
