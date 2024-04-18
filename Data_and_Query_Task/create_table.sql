CREATE TABLE TestAkasia.dbo.Employee (
  Id INT PRIMARY KEY,
  EmployeeId VARCHAR(10) UNIQUE,
  FullName VARCHAR(100),
  BirthDate DATE,
  Address VARCHAR(500)
);

CREATE TABLE TestAkasia.dbo.PositionHistory (
  Id INT PRIMARY KEY,
  PosId VARCHAR(10),
  PosTitle VARCHAR(100),
  EmployeeId VARCHAR(10),
  StartDate DATE,
  EndDate DATE,
  FOREIGN KEY (EmployeeId) REFERENCES Employee(EmployeeId)
);