INSERT INTO TestAkasia.dbo.Employee (Id, EmployeeId, FullName, BirthDate, Address)
VALUES
  (1, '10105001', 'Ali Anton', '1982-08-19', 'Jakarta Utara'),
  (2, '10105002', 'Rara Siva', '1982-01-01', 'Mandalika'),
  (3, '10105003', 'Rini Aini', '1982-02-20', 'Sumbawa Besar'),
  (4, '10105004', 'Budi', '1982-02-22', 'Mataram Kota');
  
INSERT INTO TestAkasia.dbo.PositionHistory (Id, PosId, PosTitle, EmployeeId, StartDate, EndDate)
VALUES
  (1, '50000', 'IT Manager', '10105001', '2022-01-01', '2022-02-28'),
  (2, '50001', 'IT Sr. Manager', '10105001', '2022-03-01', '2022-12-31'),
  (3, '50002', 'Programmer Analyst', '10105002', '2022-01-01', '2022-02-28'),
  (4, '50003', 'Sr. Programmer Analyst', '10105002', '2022-03-01', '2022-12-31'),
  (5, '50004', 'IT Admin', '10105003', '2022-01-01', '2022-02-28'),
  (6, '50005', 'IT Secretary', '10105003', '2022-03-01', '2022-12-31');
