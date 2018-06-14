alter session set nls_date_format='dd/mm/yy hh24:mi';
set lines 500 trims on
set pagesize 5000
col USERNAME for a12
col WAIT_CLASS for a12
col OSUSER for a10
col spid for a8
col status for a10
col machine for a30
col module for a35
col logon_time for a16
col event for a30
col CLIENT_INFO for a10
col "SID,SERIAL@INST" for a14
col "LCALL/SIW" for a12
col "BLK_SESS" for a8
select p.spid, '''' || s.sid || ',' || s.serial# || '@' || s.inst_id ||'''' "SID,SERIAL@INST",
s.blocking_session || '-' || s.blocking_instance as "BLK_SESS",
s.status,
s.last_call_et || '/' || s.seconds_in_wait as "LCALL/SIW",
s.username,
s.osuser,
s.machine,
s.sql_id,
s.prev_sql_id,
-- s.prev_hash_value,
s.event,
-- s.SQL_TRACE as TRACE,
-- s.program,
-- s.module,
-- s.client_info,
-- s.service_name,
s.logon_time,
e.wait_class
from gv$session s, gv$process p, v$event_name e
where p.addr=s.paddr
and s.inst_id = p.inst_id
and s.EVENT# = e.EVENT#
and s.username <> 'SYS'
-- and s.username = 'SYS'
-- and s.username not in ('DBSNMP','SYSMAN','SYS')
-- and s.blocking_session is not null
-- s.username is not null
-- and s.username='INTEGRA'
-- and s.osuser like '%sbl%'
and s.status='ACTIVE'
-- and s.sid='4405'
-- and s.inst_id=2
-- and s.event like '%RMAN%'
-- and s.module like '%SQL%'
-- and sql_id ='2dvzwrn6su0s8'
-- and s.service_name='satelites'
 order by s.logon_time
--order by last_call_et;
/
