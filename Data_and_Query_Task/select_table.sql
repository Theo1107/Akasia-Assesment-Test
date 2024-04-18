SELECT
  e.EmployeeId,
  e.FullName,
  e.BirthDate,
  e.Address,
  ph.PosId,
  ph.PosTitle,
  ph.StartDate,
  ph.EndDate
FROM
  TestAkasia.dbo.Employee e
LEFT JOIN (
	SELECT
	    EmployeeId,
	    MAX(StartDate) AS MaxStartDate
  	FROM
    	TestAkasia.dbo.PositionHistory
  	GROUP BY
    	EmployeeId
) lph 
ON e.EmployeeId = lph.EmployeeId
LEFT JOIN TestAkasia.dbo.PositionHistory ph
ON lph.EmployeeId = ph.EmployeeId AND lph.MaxStartDate = ph.StartDate;