#! /bin/bash

# ORG="craftybones"
# REPO="basic_tests"
# PROJECT_NAME="Ludo"
ACCEPT_HEADER="Accept: application/vnd.github.inertia-preview+json"
AUTH_HEADER="Authorization: token ${GITHUB_TOKEN}"

# create project
echo "Creating project ${PROJECT_NAME} under ${ORG}/${REPO}"
curl -H "${ACCEPT_HEADER}" -H "${AUTH_HEADER}" -X POST https://api.github.com/repos/${ORG}/${REPO}/projects -d "{\"name\":\"${PROJECT_NAME}\"}" > result.json

# get project id
echo "getting project_id"
project_id=`node -e "a=require('./result.json');console.log(a.id)"`
echo "project_id is ${project_id}"

# create column ready for analysis
declare -a arr=("Ready For Analysis" "In Analysis" "Ready For Dev" "In Dev" "Ready For QA" "In QA" "Done")

## now loop through the above array
for col in "${arr[@]}"
do
   echo "Creating column $col"
   curl -H "${ACCEPT_HEADER}" -H "${AUTH_HEADER}" -X POST https://api.github.com/projects/${project_id}/columns -d "{\"name\":\"${col}\"}"
done
echo "Creating column ready for analysis"


# create milestones
declare -a times=("2018-02-14T18:00:00Z" "2018-02-17T18:00:00Z" "2018-02-21T18:00:00Z" "2018-02-24T18:00:00Z" "2018-02-28T18:00:00Z" "2018-03-03T18:00:00Z" "2018-03-07T18:00:00Z")

for i in "${!times[@]}"
do
  echo "Creating milestone Iteration ${i} due on ${times[$i]}"
  curl -H "${AUTH_HEADER}" -X POST https://api.github.com/repos/${ORG}/${REPO}/milestones -d "{\"title\":\"Iteration ${i}\", \"due_on\":\"${times[$i]}\"}"
done

# create labels
declare -a labels=("small" "medium" "large")
declare -a colors=("0e8a16" "fbca04" "d93f0b")
for i in "${!labels[@]}"
do
  echo "Creating label ${labels[$i]} with color ${colors[$i]}"
  curl -H "${AUTH_HEADER}" -X POST https://api.github.com/repos/${ORG}/${REPO}/labels -d "{\"name\":\"${labels[$i]}\", \"color\":\"${colors[$i]}\"}"
done
