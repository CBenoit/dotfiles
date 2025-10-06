#/bin/bash

project="$1"

echo "Project path: $project"

while true; do
  dotnet nuget locals --clear all
  dotnet build "$project" && exit
  git reset --hard HEAD~1
done;
