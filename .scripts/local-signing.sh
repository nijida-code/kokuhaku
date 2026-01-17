#!/bin/bash

# The first argument determines the mode (clean or smudge)
MODE=$1

case "$MODE" in
    clean)
        # What to do before staging/committing (e.g., remove local paths)
        # Input comes from stdin, output goes to stdout
        sed -E 's/(DEVELOPMENT_TEAM = )[A-Z0-9]+;/\1TEAM_ID_PLACEHOLDER;/g'
        ;;
    smudge)
        # What to do when checking out (e.g., restore local paths)
        # Input comes from stdin, output goes to stdout
        REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
        LOCAL_SIGNING_FILE="$REPO_ROOT/.local-signing"
        
        # Default to empty if file missing
        TEAM_ID=""
        if [ -f "$LOCAL_SIGNING_FILE" ]; then
          # Trim whitespace/newlines
          TEAM_ID="$(tr -d '\r' < "$LOCAL_SIGNING_FILE" | tr -d '\n')"
        fi
        
        # If TEAM_ID is empty, just pass through unchanged
        if [ -z "$TEAM_ID" ]; then
          printf "%s" "$INPUT_CONTENT"
          exit 0
        fi
        
        # Replace placeholder with the local team id
        printf "%s" "$INPUT_CONTENT" | sed -E 's/(DEVELOPMENT_TEAM = )TEAM_ID_PLACEHOLDER;/\1$TEAM_ID;/g'
        ;;
    *)
        # Default: just pass through if no valid mode is provided
        cat
        ;;
esac
