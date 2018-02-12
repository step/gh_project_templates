#! /bin/bash

export ORG="STEP-tw"
declare -a repos=("stratego-gamblers" "ludo-dvamps" "battleship-phoenix" "cluedo-brainyfools" "acquire-legends")
declare -a projects=("Stratego" "Ludo" "Battleship" "Cluedo" "Acquire")

for i in "${!repos[@]}"
do
  export REPO=${repos[$i]}
  export PROJECT_NAME=${projects[$i]}
  echo "Creating ${PROJECT_NAME} in ${ORG}/${REPO}"
  ./setup_template.sh
done
