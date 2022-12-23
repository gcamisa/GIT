#!/bin/bash
#fanania

#export ORACLE_SID=rcup1


sqlplus -s /nolog   <<EOF
whenever oserror exit failure
whenever sqlerror exit sql.sqlcode
connect / as sysdba
set lines 1000
SELECT  p.spid "UX-Pid",substr(rtrim(w.event)||': '||rtrim(w.p1text,' ')||' '||to_char(w.p1)||','||
        rtrim(w.p2text,' ')||' '||to_char(w.p2)||','||rtrim(w.p3text,' ')||' '||to_char(w.p3),1,50) "Waiting on...",
        w.SECONDS_IN_WAIT "sec_in_wait",decode(w.WAIT_TIME,0,'In Attesa'),w.sid,s.username username,p.program program
        FROM v\$process p, v\$session s, v\$session_wait w
        WHERE w.wait_time=0
        and w.sid=s.sid and s.paddr=p.addr
        and w.event not like 'SQL*Net message from client%' and w.event not like '%rdbms ipc message%'
        and  w.event not like '%pmon timer%' and  w.event not like '%smon timer%' 
        and s.username not in ('DBSNMP','SYSMAN');
EOF
