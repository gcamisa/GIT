#!/bin/bash
#gcamisa
# Lock e dettagli di chi blocca chi

#export ORACLE_SID=rcup1


sqlplus -s /nolog   <<EOF
whenever oserror exit failure
whenever sqlerror exit sql.sqlcode
connect / as sysdba

select
   c.owner,
   c.object_name,
   c.object_type,
   b.sid,
   b.serial#,
   b.status,
   b.osuser,
   b.machine
from
   v\$locked_object a ,
   v\$session b,
   dba_objects c
where
   b.sid = a.session_id
and
   a.object_id = c.object_id;

EOF
