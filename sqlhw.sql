--به نظرم employee مناسب تر است زیرا هر سطر این جدول 
--اطلاعات مربوط به یک کارمند را در اختیار ما می گذارد
--و در کل استاندارد دیتابیس است
CREATE TABLE employee (
  id INT PRIMARY KEY,
   latinname VARCHAR(100),
   firstname NVARCHAR(100),
   lastname NVARCHAR(100),
  status VARCHAR(50)
)

ALTER TABLE employee
ADD is_remote int check (is_remote<10 and is_remote>=0);

 ALTER TABLE employee
 ADD "Date of hire" DATE;

 ALTER TABLE employee
 ADD "foreign" bit;

 CREATE TABLE team (
  team_id INT PRIMARY KEY,
  team_name VARCHAR(255) NOT NULL
);

ALTER TABLE employee
ADD team_id INT;

ALTER TABLE employee
ADD FOREIGN KEY (team_id) REFERENCES team(team_id);

UPDATE employee
SET status = 2
WHERE (is_remote = 1);

--SELECT COUNT(id) AS row_count
--from employee;



INSERT INTO employee (id, status, is_remote)
VALUES (1, '3', 3);

INSERT INTO employee (id, status, is_remote)
VALUES (4, '3', 3);

INSERT INTO employee (id, status, is_remote)
VALUES (5, '3', 1);

DECLARE @counter int;
SET @counter = 1;
DECLARE @row_count int;
SELECT @row_count = COUNT(id) FROM employee;
DECLARE @isremoteofithrow int;
WHILE (@counter <= @row_count)
BEGIN
	SELECT is_remote AS isremoteofithrow
	FROM employee
	ORDER BY is_remote
	OFFSET @counter - 1 ROWS
	FETCH NEXT 1 ROW ONLY;
	
	IF @isremoteofithrow = 1
	BEGIN
		SELECT * FROM employee;
	END
		--WITH CTE AS
		--(
		--	SELECT ROW_NUMBER() OVER (ORDER BY is_remote) AS RowNumber,
		--		   status
		--	FROM  employee
		-- )
		-- UPDATE CTE Set status= '3' WHERE RowNumber = @counter;

	SET @counter = @counter + 1;
END

SELECT * FROM employee;
--به طور کلی لوپ استاندارد sql  نیست
--اما update استاندارد هست
-- کلا آپدیت بر اساس set یا where  کار می کند و ساده تر است
--اما خوب با لوپ ما آزادی بیشتری داریم برای شرط گذاری


 ALTER TABLE employee
 ADD CONSTRAINT Name UNIQUE (firstname,lastName); 
