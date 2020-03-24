 -- many metrics in one query (PostgreSQL version)
SELECT *
FROM
  (
  SELECT 10 AS `Position`, 'Deployments' AS Metric, COUNT(*) AS Count, '' AS GroupName FROM ACT_RE_DEPLOYMENT
  UNION SELECT 11, 'Process Definitions', COUNT(*), '' FROM (SELECT DISTINCT KEY_ FROM ACT_RE_PROCDEF) AS PROCDEF
  UNION SELECT 12, 'Process Definition Versions', COUNT(*), '' FROM ACT_RE_PROCDEF
  UNION SELECT 20, 'Activity Instances', COUNT(*), '' FROM ACT_HI_ACTINST
  UNION SELECT 21, 'Process Instances', COUNT(*), '' FROM ACT_HI_PROCINST
  UNION SELECT 22, 'Process Instances (finished)', COUNT(*), '' FROM ACT_HI_PROCINST WHERE END_TIME_ IS NOT NULL
  UNION SELECT 30, 'Process Instances (running)', COUNT(*), '' FROM ACT_RU_EXECUTION WHERE PARENT_ID_ IS NULL
  UNION SELECT 30.1, 'Executions (running)', COUNT(*), '' FROM ACT_RU_EXECUTION
  UNION SELECT 31, 'User Tasks', COUNT(*), '' FROM ACT_RU_TASK
  UNION SELECT 32, 'User Tasks (unassigned)', COUNT(*), '' FROM ACT_RU_TASK WHERE ASSIGNEE_ IS NULL
  UNION SELECT 40, 'Event Subscriptions', COUNT(*), '' FROM ACT_RU_EVENT_SUBSCR
  UNION SELECT 41, 'Event Subscriptions (by type)',
    COUNT(*),
    EVENT_TYPE_ ||
    CASE WHEN PROC_INST_ID_ IS NULL THEN ' start' ELSE 'intermediate' END || ')' AS GroupName FROM ACT_RU_EVENT_SUBSCR
    GROUP BY GroupName
  UNION SELECT 50, 'Jobs', COUNT(*), '' FROM ACT_RU_JOB
  UNION SELECT 51, 'Jobs (running)', COUNT(*), '' FROM ACT_RU_JOB
    WHERE (LOCK_OWNER_ IS NOT NULL AND LOCK_EXP_TIME_ >= NOW())
  UNION SELECT 51.0, 'Jobs (running by node)', COUNT(*), LOCK_OWNER_ FROM ACT_RU_JOB
    WHERE (LOCK_OWNER_ IS NOT NULL AND LOCK_EXP_TIME_ >= NOW())
    GROUP BY LOCK_OWNER_
  UNION SELECT 51.1, 'Jobs (running by prio)',
    COUNT(*), PRIORITY_  FROM ACT_RU_JOB
    WHERE (LOCK_OWNER_ IS NOT NULL AND LOCK_EXP_TIME_ >= NOW())
    GROUP BY PRIORITY_
  UNION SELECT 52, 'Jobs (due)', COUNT(*), '' FROM ACT_RU_JOB
    WHERE (RETRIES_ > 0)
    AND (DUEDATE_ IS NULL OR DUEDATE_ < NOW())
    AND (LOCK_OWNER_ IS NULL OR LOCK_EXP_TIME_ < NOW())
    AND (SUSPENSION_STATE_ = 1 OR SUSPENSION_STATE_ IS NULL)
  UNION SELECT 52.1, 'Jobs (due by prio)',
    COUNT(*), PRIORITY_ FROM ACT_RU_JOB
    WHERE (RETRIES_ > 0)
    AND (DUEDATE_ IS NULL OR DUEDATE_ < NOW())
    AND (LOCK_OWNER_ IS NULL OR LOCK_EXP_TIME_ < NOW())
    AND (SUSPENSION_STATE_ = 1 OR SUSPENSION_STATE_ IS NULL)
    GROUP BY PRIORITY_
  UNION SELECT 52.2, 'Jobs (due by type)',
    COUNT(*), TYPE_ FROM ACT_RU_JOB
    WHERE (RETRIES_ > 0)
    AND (DUEDATE_ IS NULL OR DUEDATE_ < NOW())
    AND (LOCK_OWNER_ IS NULL OR LOCK_EXP_TIME_ < NOW())
    AND (SUSPENSION_STATE_ = 1 OR SUSPENSION_STATE_ IS NULL)
    GROUP BY TYPE_
  UNION SELECT 52.3, 'Jobs (due by job handler)',
    COUNT(*), HANDLER_TYPE_ FROM ACT_RU_JOB
    WHERE (RETRIES_ > 0)
    AND (DUEDATE_ IS NULL OR DUEDATE_ < NOW())
    AND (LOCK_OWNER_ IS NULL OR LOCK_EXP_TIME_ < NOW())
    AND (SUSPENSION_STATE_ = 1 OR SUSPENSION_STATE_ IS NULL)
    GROUP BY HANDLER_TYPE_
  UNION SELECT 52.4, 'Jobs (due by process)',
    COUNT(*), PROCESS_DEF_KEY_ FROM ACT_RU_JOB
    WHERE (RETRIES_ > 0)
    AND (DUEDATE_ IS NULL OR DUEDATE_ < NOW())
    AND (LOCK_OWNER_ IS NULL OR LOCK_EXP_TIME_ < NOW())
    AND (SUSPENSION_STATE_ = 1 OR SUSPENSION_STATE_ IS NULL)
    GROUP BY PROCESS_DEF_KEY_
  UNION SELECT 53, 'Jobs (waiting for timer)', COUNT(*), '' FROM ACT_RU_JOB
    WHERE (RETRIES_ > 0)
    AND (DUEDATE_ IS NOT NULL AND DUEDATE_ >= NOW())
    AND (LOCK_OWNER_ IS NULL OR LOCK_EXP_TIME_ < NOW())
    AND (SUSPENSION_STATE_ = 1 OR SUSPENSION_STATE_ IS NULL)
  UNION SELECT 54, 'Jobs (suspended)', COUNT(*), '' FROM ACT_RU_JOB WHERE SUSPENSION_STATE_ = 2
  UNION SELECT 55, 'Jobs (failed)', COUNT(*), '' FROM ACT_RU_JOB WHERE RETRIES_ = 0
  UNION SELECT 56, 'Jobs (timeout)', COUNT(*), '' FROM ACT_RU_JOB
    WHERE (LOCK_OWNER_ IS NOT NULL AND LOCK_EXP_TIME_ < NOW())
  UNION SELECT 59, 'Jobs (by type)', COUNT(*), TYPE_ FROM ACT_RU_JOB GROUP BY TYPE_
  UNION SELECT 60, 'Process Variables', COUNT(*), '' FROM ACT_RU_VARIABLE
  ) AS Metrics
ORDER BY `Position`, Metric;