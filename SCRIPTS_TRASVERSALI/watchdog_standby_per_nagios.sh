#!/bin/bash
#fanania richiesto da cinzia   Dettagli Ticket#: 2010111530001652 ] Cancellazione Log del cup integratore e Cup Web Regionale
. /home/oracle/.bash_profile
export DATA=`date +"%d_%m_%Y_%H.%M"`
export LOG_FILE=/orashellcrontab/LOGS/watchdog_stadby.log
#echo "Inizio shrink $DATA"  > $LOG_FILE
$ORACLE_HOME/bin/sqlplus -s /NOLOG <<EOF >> $LOG_FILE 2>&1
connect system/hp9206;
whenever oserror exit failure
whenever sqlerror exit sql.sqlcode
@/orashellcrontab/watchdog.sql
exit sql.sqlcode
EOF
#export DATA=`date +"%d_%m_%Y_%H.%M"`
#echo "fine shrink $DATA"  >> $LOG_FILE
