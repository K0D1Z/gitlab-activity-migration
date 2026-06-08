#!/bin/bash

# Uzupełnij swoim adresem e-mail z GitLaba
AUTHOR_EMAIL="twoj.email@student.agh.edu.pl" 

REPOS=(
    "git@gitlab.com:team_zakolaki_warsztat_programisty/lab-13.git"
    "git@gitlab.com:team_zakolaki_warsztat_programisty/lab-12.git"
    "git@gitlab.com:team_zakolaki_warsztat_programisty/lab-11.git"
    "git@gitlab.com:team_zakolaki_warsztat_programisty/lab-10.git"
    "git@gitlab.com:team_zakolaki_warsztat_programisty/lab-09.git"
    "git@gitlab.com:team_zakolaki_warsztat_programisty/lab-08.git"
    "git@gitlab.com:team_zakolaki_warsztat_programisty/lab-07.git"
    "git@gitlab.com:team_zakolaki_warsztat_programisty/lab-06.git"
    "git@gitlab.com:team_zakolaki_warsztat_programisty/lab-05.git"
    "git@gitlab.com:team_zakolaki_warsztat_programisty/lab-04.git"
    "git@gitlab.com:team_zakolaki_warsztat_programisty/lab-03.git"
    "git@gitlab.com:team_zakolaki_warsztat_programisty/lab-02.git"
    "git@gitlab.com:team_zakolaki_warsztat_programisty/lab-01.git"
    "git@gitlab.com:bobot_kz/pp2-lab1-printing.git"
    "git@gitlab.com:bobot_kz/pp2-lab2-systems.git"
    "git@gitlab.com:bobot_kz/pp-2-lab-3-inheritance-copy.git"
    "git@gitlab.com:bobot_kz/pp2-lab4-simple-string.git"
    "git@gitlab.com:bobot_kz/pp2-lab5-container-benchmark.git"
    "git@gitlab.com:bobot_kz/pp2-lab6-shapes-drawing.git"
    "git@gitlab.com:bobot_kz/pp2-lab7-matrix-2d.git"
    "git@gitlab.com:bobot_kz/pp2-lab8-unique-object-list-inside-parser.git"
    "git@gitlab.com:bobot_kz/pp2-lab9-sorted-unique-vectored-list.git"
    "git@gitlab.com:bobot_kz/pp2-lab10-ptr-c-string-vector.git"
    "git@gitlab.com:bobot_kz/pp-2-lab-11-file-matrix-most-recent.git"
    "git@gitlab.com:bobot_kz/pp2-lab11-file-matrix.git"
    "git@gitlab.com:bobot_kz/pp2-lab12-my-string.git"
    "git@gitlab.com:bobot_kz/pp2-lab13-templates-my-list-and-my-sort.git"
)

echo "=== ROZPOCZYNANIE SYNCHRONIZACJI ==="
for REPO in "${REPOS[@]}"; do
    echo "Pobieranie metadanych z: $REPO"
    
    git clone --bare "$REPO" temp_bare_repo
    
    cd temp_bare_repo || exit
    
    # Pobieramy daty Twoich commitów
    DATES=$(git log --all --author="$AUTHOR_EMAIL" --format="%ad")
    
    cd ..
    
    # Wyciągamy nazwę projektu dla czytelności historii
    REPO_NAME=$(basename "$REPO" .git)
    
    while IFS= read -r DATE; do
        if [ -n "$DATE" ]; then
            GIT_AUTHOR_DATE="$DATE" GIT_COMMITTER_DATE="$DATE" git commit --allow-empty -m "GitLab contribution: $REPO_NAME" > /dev/null
        fi
    done <<< "$DATES"

    rm -rf temp_bare_repo
    echo "Dodano lokalnie aktywność z: $REPO_NAME"
done

echo "----------------------------------------"
echo "Gotowe. Wykonaj 'git push', aby zaktualizować statystyki na GitHubie."
