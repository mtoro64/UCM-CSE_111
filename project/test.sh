#!/bin/bash

db="BO2.sqlite"
rm -f ${db}
touch ${db}

sqlite3 $db < create-tables.sql