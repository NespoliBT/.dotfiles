#!/usr/bin/env bash

notes=$(ls ~/notes/* 2>/dev/null)

selected_note=$(gum choose $notes)
newNotesNames=(
  "New Note" "Untitled Note" "How to build nuclear reactor" "Thoughts on Life"
)
random_note_name=${newNotesNames[$RANDOM % ${#newNotesNames[@]}]}

if [ -n "$selected_note" ]; then
  nvim "$selected_note"
else
  newNote=$(gum input --placeholder "$random_note_name" --prompt "Enter the name of the new note: ")

  if [ -n "$newNote" ]; then
    nvim ~/notes/"$newNote".md
  else
    echo "No note selected or created."
  fi
fi
