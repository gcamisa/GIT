#!/bin/bash
#fanania

#export ORACLE_SID=rcup1


sqlplus -s /nolog   <<EOF
whenever oserror exit failure
whenever sqlerror exit sql.sqlcode
SET LINESIZE 250
SET PAGESIZE 1000

COLUMN username FORMAT A9
COLUMN module FORMAT A9
COLUMN sid FORMAT 99999
COLUMN serial# FORMAT 999999
COLUMN wait_class FORMAT A15
COLUMN state FORMAT A19
COLUMN logon_time FORMAT A20
connect / as sysdba
select distinct username, osuser, machine, program from gv\$session where machine not like 'asprod%' and machine not in ('ex02fedb01.ad.lepida.it', 'ex02fedb02.ad.lepida.it') order by machine, program;

EOF
