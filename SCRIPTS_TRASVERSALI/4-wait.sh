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
SELECT NVL(a.username, '(oracle)') AS username,
       a.sid,
       a.serial#,
       d.spid AS process_id,
       a.wait_class,
       a.seconds_in_wait,
       a.state,
       a.blocking_session,
       a.blocking_session_status stato,
       a.module,
       TO_CHAR(a.logon_Time,'DD-MON-YYYY HH24:MI:SS') AS logon_time
FROM   v\$session a,
       v\$process d
WHERE  a.paddr  = d.addr
AND    a.status = 'ACTIVE' and a.username not like '(orac%'
ORDER BY 1,2;
EOF
