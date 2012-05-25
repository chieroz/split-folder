#!/bin/bash

# Split My Directory v1.0 
# 2012 Carlo Mario Chierotti c.chierotti@gmail.com

# this script splits a (possibly huge) directory
# in a bunch of directories of fixed size

# use at your own risk. 

# SET PATH TO ORIGIN & DESTINATION
# DON'T FORGET THE ENDING SLASH

MYORIGIN=/path/to/your/origin/folder/
MYDESTINATION=/path/to/your/destination/folder/

LISTA=`ls $MYORIGIN`
LISTARRAY=($LISTA)

FOLDERCOUNTER=1

# SET FOLDERSIZE TO THE DESIRED SIZE (IE NUMBER OF FILES)
FOLDERSIZE=5000

FILECOUNT=`ls $MYORIGIN | wc -l`

# GET THE NUMBER OF FOLDER WE NEED TO CREATE
let "FOLDERLIMIT = ($FILECOUNT / $FOLDERSIZE) + 1"

echo "you have $FILECOUNT files"
echo "the script will create $FOLDERLIMIT folders"

FILECOUNTER=1
FILENUMBER=1

while [ $FOLDERCOUNTER -le $FOLDERLIMIT ]
do
        echo "$MYDESTINATION$FOLDERCOUNTER created"
        mkdir -p $MYDESTINATION$FOLDERCOUNTER

        while [ $FILECOUNTER -le $FOLDERSIZE ]
        do
                let "FILENUMBER = $FILECOUNTER + ($FOLDERCOUNTER * $FOLDERSIZE)"

                if [ -f $MYORIGIN${LISTARRAY[$FILENUMBER]} ]
                then
                    # COPY EACH FILE IN THE DESTINATION FOLDER
                    # SAFER COPYING THAN MOVING...
                    cp $MYORIGIN/${LISTARRAY[$FILENUMBER]} $MYDESTINATION$FOLDERCOUNTER/${LISTARRAY[$FILENUMBER]}
                    if [ -f $MYDESTINATION$FOLDERCOUNTER/${LISTARRAY[$FILENUMBER]} ]
                    then
                        echo "file ${LISTARRAY[$FILENUMBER]} copied"
                    else
                        echo "error"
                        exit
                    fi
                else
                    # STOP WHEN WE RUN OUT OF FILES
                    echo "file doesn't exist"
                    exit
                fi
                let "FILECOUNTER++"
        done
        let "FILECOUNTER=1"

        echo ""
        let "FOLDERCOUNTER++"
done
