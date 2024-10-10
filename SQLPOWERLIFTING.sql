select top 50 * from POWERLIFTING;

--dots by age
SELECT Age_Range, Equipment, AVG(Dots) AS Average_Dots
FROM
(
	SELECT Dots, Equipment,
	CASE
		WHEN Age>=5 AND Age<10 THEN '5-9'
		WHEN Age>=10 AND Age<15 THEN '10-14'
		WHEN Age>=15 AND Age<20 THEN '15-19'
		WHEN Age>=20 AND Age<25 THEN '20-24'
		WHEN Age>=25 AND Age<30 THEN '25-29'
		WHEN Age>=30 AND Age<35 THEN '30-34'
		WHEN Age>=35 AND Age<40 THEN '35-39'
		WHEN Age>=40 AND Age<45 THEN '40-44'
		WHEN Age>=45 AND Age<50 THEN '45-49'
		WHEN Age>=50 AND Age<55 THEN '50-54'
		WHEN Age>=55 AND Age<60 THEN '55-59'
		WHEN Age>=60 AND Age<65 THEN '60-64'
		WHEN Age>=65 AND Age<70 THEN '65-69'
		WHEN Age>=70 AND Age<75 THEN '70-74'
		WHEN Age>=75 AND Age<80 THEN '75-79'
		WHEN Age>=80 THEN '80+'
	END AS Age_Range
	FROM POWERLIFTING
	WHERE Age IS NOT NULL AND Dots IS NOT NULL AND Equipment IS NOT NULL AND Age>=5 AND Event='SBD'
) AS T2
GROUP BY Age_Range, Equipment
ORDER BY Equipment, Age_Range, Average_Dots;


--total weight by age
SELECT Age_Range, Sex, Equipment, AVG(TotalKg) AS Average_Weight
FROM
(
	SELECT Sex, TotalKg, Equipment,
	CASE
		WHEN Age>=5 AND Age<10 THEN '5-9'
		WHEN Age>=10 AND Age<15 THEN '10-14'
		WHEN Age>=15 AND Age<20 THEN '15-19'
		WHEN Age>=20 AND Age<25 THEN '20-24'
		WHEN Age>=25 AND Age<30 THEN '25-29'
		WHEN Age>=30 AND Age<35 THEN '30-34'
		WHEN Age>=35 AND Age<40 THEN '35-39'
		WHEN Age>=40 AND Age<45 THEN '40-44'
		WHEN Age>=45 AND Age<50 THEN '45-49'
		WHEN Age>=50 AND Age<55 THEN '50-54'
		WHEN Age>=55 AND Age<60 THEN '55-59'
		WHEN Age>=60 AND Age<65 THEN '60-64'
		WHEN Age>=65 AND Age<70 THEN '65-69'
		WHEN Age>=70 AND Age<75 THEN '70-74'
		WHEN Age>=75 AND Age<80 THEN '75-79'
		WHEN Age>=80 THEN '80+'
	END AS Age_Range
	FROM POWERLIFTING
	WHERE Age IS NOT NULL AND TotalKg IS NOT NULL AND Equipment IS NOT NULL AND Sex IS NOT NULL AND Age>=5 AND Event='SBD'
) AS T2
GROUP BY Age_Range, Equipment, Sex
ORDER BY Average_Weight;


--population by country
SELECT SUM(Number_of_lifters)
FROM(
SELECT Country, COUNT(Country) AS Number_of_lifters FROM
(
	SELECT DISTINCT Name, Sex, Country
	FROM POWERLIFTING
	WHERE Name IS NOT NULL AND Country IS NOT NULL
) AS T2
GROUP BY Country
--ORDER BY Number_of_lifters DESC
) AS T2;
--tested vs untested dots
SELECT Tested_or_untested, Equipment, AVG(Dots) AS Average_Dots
FROM
(
	SELECT Equipment, Dots,
	CASE
		WHEN Tested='YES' THEN 'Tested'
		ELSE 'Untested'
	END AS Tested_or_untested
	FROM POWERLIFTING
	WHERE Equipment IS NOT NULL AND Dots IS NOT NULL AND Event='SBD'
) AS T2
GROUP BY Tested_or_untested, Equipment
ORDER BY Tested_or_untested, Average_Dots DESC;

--male vs female jumlah total
SELECT Sex, COUNT(*) AS Jumlah
FROM
(
	SELECT DISTINCT Name, Sex
	FROM POWERLIFTING
) AS T2
GROUP BY Sex
ORDER BY Jumlah DESC;

--jumlah lifter
SELECT COUNT(*) AS Jumlah_Lifter
FROM
(
	SELECT DISTINCT Name, Sex
	FROM POWERLIFTING
) AS T2;

--average age 2023
SELECT AVG(Age) AS Average_Age
FROM
(
	SELECT DISTINCT Name, Age
	FROM POWERLIFTING
	WHERE Age IS NOT NULL AND YEAR(Date)=2023
) AS T2