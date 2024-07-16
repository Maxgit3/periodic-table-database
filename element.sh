#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $* ]]
  then
    echo "Please provide an element as an argument."
    exit
fi

if [[ $1 =~ ^[0-9]+$ ]]
  then
RESULT=$($PSQL "SELECT properties.atomic_number, types.type, properties.atomic_mass, properties.melting_point_celsius, properties.boiling_point_celsius, elements.name, elements.symbol FROM properties INNER JOIN elements ON properties.atomic_number=elements.atomic_number INNER JOIN types ON properties.type_id=types.type_id WHERE elements.atomic_number=$1")

    if [[ -z $RESULT ]]
      then
        echo "I could not find that element in the database."
        exit
    fi
    ATOM_NUM=$(echo "$RESULT" | awk -F '|' '{print $1}')
    METAL=$(echo "$RESULT" | awk -F '|' '{print $2}')
    ATOM_MASS=$(echo "$RESULT" | awk -F '|' '{print $3}')
    MELT=$(echo "$RESULT" | awk -F '|' '{print $4}')
    BOIL=$(echo "$RESULT" | awk -F '|' '{print $5}')
    NAME=$(echo "$RESULT" | awk -F '|' '{print $6}')
    SYMBOL=$(echo "$RESULT" | awk -F '|' '{print $7}')

    # echo "$RESULT" | while read ATOM_NUM BAR METAL BAR ATOM_MASS BAR MELT BAR BOIL BAR NAME BAR SYMBOL
    #   do
    #       echo "$ATOM_NUM"
    #       echo "The element with atomic number $ATOM_NUM is $NAME ($SYMBOL). It's a $METAL, with a mass of $ATOM_MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
    #   done

    echo "The element with atomic number $ATOM_NUM is $NAME ($SYMBOL). It's a $METAL, with a mass of $ATOM_MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
    
    exit
fi

LENGTH=$(expr length "$1")
SYMBOL_LENGTH=2

if [[ $LENGTH -le  $SYMBOL_LENGTH && $1 != ^[0-9]+$ ]]
  then
RESULT=$($PSQL "SELECT properties.atomic_number, types.type, properties.atomic_mass, properties.melting_point_celsius, properties.boiling_point_celsius, elements.name, elements.symbol FROM properties INNER JOIN elements ON properties.atomic_number=elements.atomic_number INNER JOIN types ON properties.type_id=types.type_id WHERE elements.symbol='$1'")

        if [[ -z $RESULT ]]
          then
            echo "I could not find that element in the database."
            exit
        fi

        ATOM_NUM=$(echo "$RESULT" | awk -F '|' '{print $1}')
        METAL=$(echo "$RESULT" | awk -F '|' '{print $2}')
        ATOM_MASS=$(echo "$RESULT" | awk -F '|' '{print $3}')
        MELT=$(echo "$RESULT" | awk -F '|' '{print $4}')
        BOIL=$(echo "$RESULT" | awk -F '|' '{print $5}')
        NAME=$(echo "$RESULT" | awk -F '|' '{print $6}')
        SYMBOL=$(echo "$RESULT" | awk -F '|' '{print $7}')

        echo "The element with atomic number $ATOM_NUM is $NAME ($SYMBOL). It's a $METAL, with a mass of $ATOM_MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
fi

if [[ $LENGTH -gt  $SYMBOL_LENGTH && $1 != ^[0-9]+$ ]]
  then
        RESULT=$($PSQL "SELECT properties.atomic_number, types.type, properties.atomic_mass, properties.melting_point_celsius, properties.boiling_point_celsius, elements.name, elements.symbol FROM properties INNER JOIN elements ON properties.atomic_number=elements.atomic_number INNER JOIN types ON properties.type_id=types.type_id WHERE elements.name='$1'")

      if [[ -z $RESULT ]]
        then
          echo "I could not find that element in the database."
          exit
      fi
      
      ATOM_NUM=$(echo "$RESULT" | awk -F '|' '{print $1}')
      METAL=$(echo "$RESULT" | awk -F '|' '{print $2}')
      ATOM_MASS=$(echo "$RESULT" | awk -F '|' '{print $3}')
      MELT=$(echo "$RESULT" | awk -F '|' '{print $4}')
      BOIL=$(echo "$RESULT" | awk -F '|' '{print $5}')
      NAME=$(echo "$RESULT" | awk -F '|' '{print $6}')
      SYMBOL=$(echo "$RESULT" | awk -F '|' '{print $7}')

      echo "The element with atomic number $ATOM_NUM is $NAME ($SYMBOL). It's a $METAL, with a mass of $ATOM_MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
fi
