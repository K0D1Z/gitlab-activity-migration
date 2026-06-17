#!/bin/bash

# Uzupełnij swoim adresem e-mail z GitLaba
AUTHOR_EMAIL="twoj.email@student.agh.edu.pl" 

REPOS=(
    "git@gitlab.com:team_zakolaki_warsztat_programisty/lab-14.git"
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
