#!/bin/bash
#gcamisa
# Lock e dettagli di chi blocca chi

#export ORACLE_SID=rcup1


sqlplus -s /nolog   <<EOF
whenever oserror exit failure
whenever sqlerror exit sql.sqlcode
connect / as sysdba

select
   (select username from v\$session where sid=a.sid) blocker,
   a.sid,
   ' is blocking ',
   (select username from v\$session where sid=b.sid) blockee,
   b.sid
from
   v\$lock a,
   v\$lock b
where
   a.block = 1
and
   b.request > 0
and
   a.id1 = b.id1
and
   a.id2 = b.id2;

EOF
