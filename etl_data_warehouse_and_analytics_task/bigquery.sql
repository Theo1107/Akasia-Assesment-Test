--CREATE TABLE `starry-hawk-411609.Test_Akasia.report_historical_training` AS
SELECT
  e.EmployeeId,
  e.FullName,
  th.TrainingName,
  th.TrainingDate_Start AS Date_Start,
  th.TrainingDate_End AS Date_End,
  th.TrainingDuration AS Training_Duration_Day,
  th.TrainingLocation,
  CASE
    WHEN th.TrainingDate_End < FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', CURRENT_TIMESTAMP()) THEN 'Completed'
    ELSE 'On Going'
  END AS Status
  FROM `starry-hawk-411609.Test_Akasia.employee` e
  JOIN `starry-hawk-411609.Test_Akasia.training_history` th ON e.EmployeeId = th.EmployeeId;

-- a. Total employee completed training each month
-- CREATE TABLE `starry-hawk-411609.Test_Akasia.total_employee_completed_training_each_month` AS
WITH cte AS (
  SELECT
    e.EmployeeId,
    EXTRACT(YEAR FROM TIMESTAMP(th.TrainingDate_Start)) AS Year, 
    EXTRACT(MONTH FROM TIMESTAMP(th.TrainingDate_Start)) AS Month,
    COUNT(*) AS TotalTraining,
    SUM(CASE WHEN th.TrainingDate_End < FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', CURRENT_TIMESTAMP()) THEN 1 ELSE 0 END) AS CompletedTraining
  FROM
    `starry-hawk-411609.Test_Akasia.employee` e
    JOIN`starry-hawk-411609.Test_Akasia.training_history` th ON e.EmployeeId = th.EmployeeId
  GROUP BY
    1,2,3
)
SELECT
  cte.Year,
  cte.Month,
  COUNT(DISTINCT cte.EmployeeId) AS TotalDistinctEmployee,
  SUM(CASE WHEN cte.CompletedTraining = cte.TotalTraining THEN 1 ELSE 0 END) AS TotalCompletedEmployee,
  SUM(CASE WHEN cte.CompletedTraining < cte.TotalTraining THEN 1 ELSE 0 END) AS TotalOngoingEmployee
FROM
  cte
GROUP BY
  1,2
ORDER BY
  1,2;
 
-- b. Total training each month
-- CREATE TABLE `starry-hawk-411609.Test_Akasia.total_training_each_month` AS
WITH cte AS (
  SELECT
    e.EmployeeId,
    e.FullName,
    th.TrainingName,
    th.TrainingDate_Start AS DATE_START,
    th.TrainingDate_End AS DATE_END,
    th.TrainingDuration AS Training_Duration_DAY,
    th.TrainingLocation,
    CASE
      WHEN th.TrainingDate_End < FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', CURRENT_TIMESTAMP()) THEN 'Completed'
      ELSE 'On Going'
    END AS Status
  FROM
    `starry-hawk-411609.Test_Akasia.employee` e
    JOIN `starry-hawk-411609.Test_Akasia.training_history` th ON e.EmployeeId = th.EmployeeId
)
SELECT
  EXTRACT(YEAR FROM TIMESTAMP(DATE_START)) AS Year,
  EXTRACT(MONTH FROM TIMESTAMP(DATE_START)) AS Month,
  COUNT(*) AS TotalTraining,
  SUM(CASE WHEN Status = 'Completed' THEN 1 ELSE 0 END) AS TotalCompletedTraining,
  SUM(CASE WHEN Status = 'On Going' THEN 1 ELSE 0 END) AS TotalOngoingTraining
FROM
  cte
GROUP BY
  1,2
;