#!/bin/bash
#fanania

#export ORACLE_SID=rcup1


sqlplus -s /nolog   <<EOF
whenever oserror exit failure
whenever sqlerror exit sql.sqlcode
connect / as sysdba
--@check.sql
set lines 1000
set pages 100
prompt
prompt
select status, error from v\$archive_dest where dest_id=2;
col VALUE for a30
col NAME for a100
col DEST_NAME for a20
col ERROR for a25
col DB_UNIQUE_NAME for a10
set lines 145
set pages 1000
select
INST_ID,DEST_NAME,STATUS,ARCHIVED_SEQ#,APPLIED_SEQ#,ERROR,DB_UNIQUE_NAME,PROTECTION_MODE 
from gv\$ARCHIVE_DEST_STATUS
where DEST_NAME='LOG_ARCHIVE_DEST_2';
select NAME,VALUE from v\$parameter where name in ('log_archive_dest_2');
EOF
