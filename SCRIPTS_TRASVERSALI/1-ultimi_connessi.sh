#!/bin/bash
#fanania

#export ORACLE_SID=rcup1
clear

sqlplus -s /nolog   <<EOF
whenever oserror exit failure
whenever sqlerror exit sql.sqlcode
connect / as sysdba
--@check.sql
set lines 1000
set pages 100
prompt
prompt
col terminal format a10
col schemaname format a10
col MACHINE format a28
break on inst_id




prompt ***failover:
SELECT
        inst_id,
	MACHINE,
        module,
	COUNT(*)
 FROM GV\$SESSION where type='USER'   and module not like 'oraagen%'
 GROUP BY inst_id,MACHINE, module order by 1;
EOF
