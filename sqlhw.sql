CREATE DATABASE training

CREATE LOGIN sass WITH PASSWORD = 'S@123'

CREATE USER Main for login sass

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



INSERT INTO employee (id, status, is_remote, firstname, lastname)
VALUES (5, '3', 1, 'a', 'b');

INSERT INTO employee (id, status, is_remote, firstname, lastname)
VALUES (4, '3', 3, 'c', 'd');

INSERT INTO employee (id, status, is_remote, firstname, lastname)
VALUES (7, '3', 1, 'e', 'f');

DECLARE @counter int;
SET @counter = 1;
DECLARE @row_count int;
SELECT @row_count = COUNT(id) FROM employee;
DECLARE @isremoteofithrow int;
WHILE (@counter <= @row_count)
BEGIN
	SELECT @isremoteofithrow = is_remote
	FROM employee
	ORDER BY is_remote
	OFFSET @counter - 1 ROWS
	FETCH NEXT 1 ROW ONLY;
	
	IF @isremoteofithrow = 1
		WITH CTE AS
		(
			SELECT ROW_NUMBER() OVER (ORDER BY is_remote) AS RowNumber,
				   status
			FROM  employee
		 )
		 UPDATE CTE Set status= '4' WHERE RowNumber = @counter;

	SET @counter = @counter + 1;
END

--loop
--ک حلقه در SQL به توانایی اجرای مکرر مجموعه ای از
--عبارات بر اساس یک شرط خاص یا تا زمانی که معیار خاصی برآورده شود، اشاره دارد.
--خوبیها:
--توانایی رسیدگی به ساختارهای داده سلسله مراتبی و وظایف بازگشتی.
--دستکاری داده های پیچیده را برای موارد استفاده خاص فعال می کند.
--CTE های بازگشتی روشی مناسب برای مدیریت جداول خود ارجاع می دهند.
--بدی ها؛
--اجرای عملیات بازگشتی و اشکال زدایی می تواند چالش برانگیز باشد.
--عملکرد ممکن است تحت تاثیر منفی قرار گیرد، به خصوص با مجموعه داده های بزرگ و بازگشت های عمیق
--برای کارهای ساده توصیه نمی شود، زیرا بر خلاف ماهیت مبتنی بر مجموعه SQL است.
--update
--دستور UPDATE در SQL برای اصلاح رکوردهای موجود در جدول استفاده می شود.
--این به شما اجازه می دهد تا مقادیر یک یا چند ستون را در یک یا چند ردیف بر اساس شرایط مشخص شده تغییر دهید.
--به روز رسانی بخشی ضروری از دستکاری داده ها در SQL است
--و معمولا برای به روز نگه داشتن داده ها و انجام تغییرات داده ها استفاده می شود.
--خوبی ها:
--روشی کارآمد برای تغییر داده ها به صورت انبوه و انجام به روز رسانی های انبوه روی یک جدول.
--به روز رسانی های مشروط را بر اساس معیارهای خاص امکان پذیر می کند.
-- به حفظ یکپارچگی و دقت داده ها در پایگاه داده کمک می کند.
--بدی ها:
--استفاده بی دقت از UPDATE بدون بند مناسب WHERE می تواند منجر به به روز رسانی های ناخواسته شود که منجر به از دست رفتن داده ها یا ناسازگاری می شود.
--وقتی روی تعداد زیادی ردیف اعمال می شود، می تواند بر عملکرد پایگاه داده تأثیر بگذارد.
--ممکن است برای جلوگیری از شرایط مسابقه یا بن بست در محیط های چند کاربره نیاز به رسیدگی دقیق داشته باشد.
--جمع بندی:
--به طور کلی update متدی رایج تر نسبت به  loop است
--تمام query ها بیشتر از Update استفاده می کنند

 ALTER TABLE employee
 ADD CONSTRAINT Name UNIQUE (firstname,lastName); 
