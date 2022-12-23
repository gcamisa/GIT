#!/bin/bash
#fanania


sqlplus -s /nolog   <<EOF
whenever oserror exit failure
whenever sqlerror exit sql.sqlcode
connect / as sysdba
alter system flush shared_pool;
EOF
