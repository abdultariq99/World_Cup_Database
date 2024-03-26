#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
#Adding teams from Winners side
#Exclude Heading
if [ "$WINNER" != "winner" ]
then
#Get Team ID which is unique
TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
#If team doesn't exists
if [ -z $TEAM_ID ]
then
INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
fi
fi


#Adding teams from opponents side

#Excluding Header
if [ "$OPPONENT" != "opponent" ]
then
#Get Team ID which is unique
TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
#If team doesn't exists
if [ -z $TEAM_ID ]
then
INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
fi
fi

#Games Table
if [ "$YEAR" != "year" ]
then
#GET WINNER ID
WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
#GET OPPONENT ID
OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
#INSERT VALUES
INSERT_VALUES=$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VAlUES('$YEAR','$ROUND','$WINNER_ID','$OPPONENT_ID','$WINNER_GOALS','$OPPONENT_GOALS')")
fi
done
