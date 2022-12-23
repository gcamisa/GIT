#!/bin/bash
#gcamisa
# Lock e dettagli di chi blocca chi

#export ORACLE_SID=rcup1


sqlplus -s /nolog   <<EOF
whenever oserror exit failure
whenever sqlerror exit sql.sqlcode
connect / as sysdba

select object_name, s.sid, s.serial#, p.spid 
from v\$locked_object l, dba_objects o, v\$session s, v\$process p
where l.object_id = o.object_id and l.session_id = s.sid and s.paddr = p.addr;

EOF
