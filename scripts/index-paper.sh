#!/usr/bin/env bash

# This function aims to validate all 

source config.shlib;

title="$(config_read_file 'config.cfg' title)";
year="$(config_read_file 'config.cfg' year)";
journal="$(config_read_file 'config.cfg' journal)";
volume="$(config_read_file 'config.cfg' volume)";
number="$(config_read_file 'config.cfg' number)";
issn="$(config_read_file 'config.cfg' issn)";
pages="$(config_read_file 'config.cfg' pages)";
doi="$(config_read_file 'config.cfg' doi)";
author="$(config_read_file 'config.cfg' author)";

echo
echo
echo '----------------------------------------------------------------'
echo This script is intended to index a paper on the NEAR protocol
echo blockchain. This script will read the config.cfg file.
echo This file has the parameters of the paper that wished to be
echo indexed. Therefore, check the information prior to executing
echo the rest of the file.
echo '----------------------------------------------------------------'

echo
read -n1 -s -r -p $'Press any key to continue...\n' key
echo '----------------------------------------------------------------'
echo

echo '----------------------------------------------------------------'
echo 'Paper details on the config.cfg'
echo
echo '-> Title:    '$title
echo '-> Author(s):'$author
echo '-> year:     '$year
echo '-> journal:  '$journal
echo '-> volume:   '$volume
echo '-> issn:     '$issn
echo '-> pages:    '$pages
echo '-> doi:      '$doi
echo '----------------------------------------------------------------'


read -r -p $'Are these details correct [y/n] ' key
echo 

if [ "$key" = 'n' ]; then
    exit 1
elif [ "$key" != 'y' ]; then
    echo '----------------------------------------------------------------'
    echo EXITTING! Did not understand input
    echo '----------------------------------------------------------------'
    exit 1
fi

echo Deploying contract \(output is going to be ignored\)!
near dev-deploy ../build/debug/singleton.wasm 1>/dev/null

CONTRACT="$(grep -E '^dev-' -m 1 './neardev/dev-account')";
echo
echo 'Near dev account: ' $CONTRACT

read -n1 -s -r -p $'Press space to continue...\n' key


echo
echo We will now check if the paper ${doi} is indexed:
near view $CONTRACT checkifindexed '{"doi":"'${doi}'"}'

echo
read -n1 -s -r -p $'Press space to continue...\n' key


echo
echo Now we will index the paper whose doi is ${doi}.
near call $CONTRACT indexpaper '{"title": "'"${title}"'",
                "author": "'"${author}"'",
                "year": "'"${year}"'",
                "journal": "'"${journal}"'",
                "volume": "'"${volume}"'",
	    	    "issn":"'"${issn}"'",
          	    "pages":"'"${pages}"'",
                "doi":"'"${doi}"'"}' --accountId $CONTRACT

echo
echo We will check again if the paper ${doi} was succefully indexed:
read -n1 -s -r -p $'Press space to continue...\n' key

near view $CONTRACT checkifindexed '{"doi":"'${doi}'"}'

echo
read -n1 -s -r -p $'Press space to continue...\n' key

echo
echo We will now delete the paper ${doi}.
near call $CONTRACT delindexed '{"doi":"'${doi}'"}' --accountId $CONTRACT 

echo
read -n1 -s -r -p $'Press space to continue...\n' key

echo
echo And Now check again if it was deleted
near view $CONTRACT checkifindexed '{"doi":"'${doi}'"}'

