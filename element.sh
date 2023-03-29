#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo 'Please provide an element as an argument.'
else


  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ELEMENT=$($PSQL"SELECT atomic_number FROM elements WHERE atomic_number="$1)
  else
  ELEMENT=$($PSQL"SELECT atomic_number FROM elements WHERE symbol='"$1"' OR name='"$1"'")
  fi
  
  if [[ -z $ELEMENT ]]
    then
    echo 'I could not find that element in the database.'
    else

    NAME=$($PSQL"SELECT name FROM elements WHERE atomic_number="$ELEMENT)
    SYMBOL=$($PSQL"SELECT symbol FROM elements WHERE atomic_number="$ELEMENT)
    TYPE=$($PSQL"SELECT type FROM properties FULL JOIN types USING (type_id) WHERE atomic_number="$ELEMENT)
    MASS=$($PSQL"SELECT atomic_mass FROM properties WHERE atomic_number="$ELEMENT)
    MELT_POINT=$($PSQL"SELECT melting_point_celsius FROM properties WHERE atomic_number="$ELEMENT)
    BOIL_POINT=$($PSQL"SELECT boiling_point_celsius FROM properties WHERE atomic_number="$ELEMENT)

   echo "The element with atomic number "$ELEMENT" is "$NAME" ("$SYMBOL"). It's a "$TYPE", with a mass of "$MASS" amu. "$NAME" has a melting point of "$MELT_POINT" celsius and a boiling point of "$BOIL_POINT" celsius."

  fi

fi
