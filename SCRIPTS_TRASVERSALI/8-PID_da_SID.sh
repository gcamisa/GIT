#!/bin/bash
#gcamisa
# Identify database SID based on OS Process ID

#export ORACLE_SID=rcup1


sqlplus -s /nolog   <<EOF
whenever oserror exit failure
whenever sqlerror exit sql.sqlcode
connect / as sysdba
set lines 1000
  col sid format 999999
  col username format a20
  col osuser format a15
  select b.spid,a.sid, a.serial#,a.username, a.osuser
  from gv\$session a, gv\$process b
  where a.paddr= b.addr
  and b.spid='&spid'
  order by b.spid;



EOF
