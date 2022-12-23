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
set feedback off
prompt
prompt
prompt **   START **
col host format a40


col name format a15
col failover_method format a15
col failover_type format a10
--col failover_retries format 10
col goal format a15
col clb_goal format a10
col aq_ha_notifications format a10

select name, failover_method, failover_type, failover_retries,goal, clb_goal,aq_ha_notifications  from dba_services
/


prompt
prompt **   END **
prompt
prompt


SET PAGESIZE 60 COLSEP '|' NUMWIDTH 8 LINESIZE 132 VERIFY OFF FEEDBACK OFF
COLUMN service_name FORMAT A20 TRUNCATED HEADING 'Service'
COLUMN begin_time HEADING 'Begin Time' FORMAT A10
COLUMN end_time HEADING 'End Time' FORMAT A10
COLUMN instance_name HEADING 'Instance' FORMAT A10
COLUMN service_time HEADING 'Service Time|mSec/Call' FORMAT 999999999
COLUMN throughput HEADING 'Calls/sec'FORMAT 99.99 
BREAK ON service_name SKIP 1 
SELECT 
    service_name 
  , TO_CHAR(begin_time, 'HH:MI:SS') begin_time 
  , TO_CHAR(end_time, 'HH:MI:SS') end_time 
  , instance_name 
  , elapsedpercall  service_time
  ,  callspersec  throughput
FROM  
    gv\$instance i     
  , gv\$active_services s     
  , gv\$servicemetric m 
WHERE s.inst_id = m.inst_id  
  AND s.name_hash = m.service_name_hash
  AND i.inst_id = m.inst_id
  AND m.group_id = 10
ORDER BY
   service_name
 , i.inst_id
 , begin_time ;



EOF
