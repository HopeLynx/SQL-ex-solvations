-- 1
SELECT model,speed,hd FROM PC WHERE price < 500

--2
SELECT DISTINCT maker from Product WHERE type = 'Printer'

-- 3
SELECT model,ram,screen FROM Laptop WHERE price > 1000

-- 4
SELECT * FROM Printer WHERE color = 'y'

-- 5
SELECT model,speed,hd FROM PC WHERE price < 600 AND  (cd='12x' or cd = '24x')

-- 6
SELECT DISTINCT Product.maker,Laptop.speed
FROM Laptop 
JOIN Product ON Product.model = Laptop.model
WHERE Laptop.hd >= 10

-- 7
SELECT Product.model AS model, price   
FROM Product INNER JOIN 
PC ON PC.model=Product.model WHERE maker = 'B'
UNION
SELECT Product.model AS model, price   
FROM Product INNER JOIN 
Laptop ON Laptop.model=Product.model WHERE maker = 'B'
UNION
SELECT Product.model AS model, price   
FROM Product INNER JOIN 
Printer ON Printer.model=Product.model WHERE maker = 'B'


-- 8 почти решение
SELECT DISTINCT maker from Product
WHERE maker NOT IN
(SELECT DISTINCT maker from Product
INNER JOIN Laptop ON Laptop.model=Product.model)
AND maker IN 
(SELECT DISTINCT maker from Product
INNER JOIN PC ON PC.model=Product.model)

-- 8 
SELECT DISTINCT maker
FROM product
WHERE type = 'pc'
EXCEPT
SELECT DISTINCT product.maker
FROM product
Where type = 'laptop'

-- 9
SELECT DISTINCT maker from Product
INNER JOIN PC ON PC.model=Product.model
WHERE speed >= 450

-- 10
SELECT model,price FROM Printer WHERE price = (select MAX(price) FROM printer)

-- 11
SELECT AVG(speed) FROM PC

-- 12
SELECT AVG(speed) FROM Laptop WHERE price > 1000

-- 13
SELECT AVG(speed) FROM PC
JOIN Product ON PC.model=Product.model
WHERE maker = 'A'

-- 14
SELECT Ships.class, name, Classes.country FROM Ships
JOIN Classes ON Classes.class = Ships.class
WHERE numGuns >= 10

-- 15
SELECT hd FROM PC GROUP BY hd HAVING COUNT(HD) >= 2

-- 16
SELECT DISTINCT PC1.model, PC2.model, PC1.speed, PC1.ram
FROM PC PC1, PC PC2
WHERE PC1.speed = PC2.speed and PC1.ram = PC2.ram and PC1.model>PC2.model

-- 17
SELECT DISTINCT Product.type,Laptop.model,speed
FROM Laptop
JOIN Product ON Laptop.model=Product.model
WHERE speed < ALL(SELECT speed FROM PC)

-- 18
SELECT DISTINCT Product.maker, Printer.price 
FROM Printer
JOIN Product ON Printer.model=Product.model
WHERE Printer.price = (SELECT MIN(price) FROM Printer WHERE color = 'y' ) and Printer.color = 'y'

-- 19
SELECT Product.maker, AVG(screen) FROM Laptop
JOIN Product ON Laptop.model=Product.model
GROUP BY maker

-- 20
SELECT Product.maker, COUNT(model) as Count_Model FROM Product
WHERE type = 'PC'
GROUP BY maker HAVING COUNT(DISTINCT model) >= 3

-- 21
SELECT DISTINCT Product.maker,MAX(price) from PC
JOIN Product ON PC.model=Product.model
GROUP BY maker

-- 22  
SELECT speed, AVG(price) FROM PC WHERE speed > 600 GROUP BY speed

-- 23
SELECT DISTINCT maker FROM Product 
JOIN PC ON Product.model=PC.model WHERE PC.speed >= 750 and maker IN
(
SELECT maker from Product 
 JOIN Laptop on Product.model=Laptop.model
 WHERE Laptop.speed >= 750
)

-- 24
WITH prices AS (
SELECT Product.maker,PC.model, PC.price FROM PC
JOIN Product ON PC.model=Product.model
UNION ALL
SELECT Product.maker,Laptop.model, Laptop.price FROM Laptop
JOIN Product ON Laptop.model=Product.model
UNION ALL
SELECT Product.maker,Printer.model, Printer.price FROM Printer
JOIN Product ON Printer.model=Product.model
) SELECT DISTINCT model FROM prices WHERE price = (SELECT MAX(price) FROM prices)

-- 25
SELECT DISTINCT maker from Product
WHERE maker IN 
(SELECT DISTINCT maker from Product
JOIN PC ON Product.model= PC.model WHERE
PC.speed = (SELECT MAX(speed) FROM PC WHERE PC.ram = (SELECT MIN(ram) FROM PC))
and ram = (SELECT MIN(ram) FROM PC))
and maker IN (SELECT DISTINCT maker FROM Product WHERE type = 'Printer')

-- 26
WITH prices AS (
SELECT Product.maker,PC.model, PC.price FROM PC
JOIN Product ON PC.model=Product.model
UNION ALL
SELECT Product.maker,Laptop.model, Laptop.price FROM Laptop
JOIN Product ON Laptop.model=Product.model
)
SELECT AVG(price) AS AVG_price FROM prices WHERE maker = 'A'

-- 27
WITH pc_full AS (
SELECT Product.maker,PC.model,speed,ram,hd,cd,price FROM PC
JOIN Product ON PC.model=Product.model
) SELECT maker, AVG(hd) AS Avg_hd FROM pc_full 
GROUP BY maker HAVING maker IN (SELECT DISTINCT maker from Product WHERE type = 'Printer')

-- 28
WITH tmp AS (SELECT DISTINCT maker FROM Product 
GROUP BY maker HAVING COUNT(model) = 1) SELECT COUNT(maker) AS qty FROM tmp

-- 29
SELECT inp.point, inp.date, inc, out
FROM income_o inp LEFT JOIN outcome_o outp ON inp.point = outp.point
AND inp.date = outp.date
UNION
SELECT outp.point, outp.date, inc, out
FROM income_o inp RIGHT JOIN outcome_o outp ON inp.point = outp.point
AND inp.date = outp.date

-- 30
SELECT point, date, SUM(sum_out) , SUM(sum_inc) FROM
(
SELECT point, date, SUM(inc) as sum_inc, null as sum_out 
FROM Income GROUP BY point, date
UNION
SELECT point, date, null as sum_inc, SUM(out) as sum_out
FROM Outcome GROUP BY point, date
) AS t GROUP BY point,date ORDER BY point

-- 31
SELECT class,country FROM classes WHERE bore >= 16

-- 33
SELECT ship FROM Outcomes WHERE battle = 'North Atlantic' AND result = 'sunk'




-- 1r
-- FAILED
SELECT DISTINCT Product.model FROM Product
JOIN PC Kostya ON Kostya.model = Product.model,
JOIN PC Misha ON Misha.model = Product.model,
JOIN Laptop Dima ON Dima.model = Product.model,
JOIN Laptop Olya ON Olya.model = Product.model,
JOIN Printer Tanya ON Tanya.model = Product.model,
JOIN Printer Vitya ON Vitya.model = Product.model
WHERE
--Dima.maker = Misha.maker and
Tanya.type <> Vitya.type and
Tanya.color = Vitya.color and
Dima.screen = Olya.screen+3 and
Misha.price = 4*Tanya.price and
stuff(Vitya.model, 3, 1, '') = stuff(Olya.model, 3, 1, '') and
Kostya.speed = Misha.speed and Kostya.hd = Dima.hd and Kostya.ram = Olya.ram and
Kostya.price = Vitya.price

-- WORKING
SELECT DISTINCT Kostya.model
FROM
(SELECT prod.maker, l.hd, l.screen
 FROM product prod
 JOIN laptop l on l.model = prod.model) Dima,
(SELECT prod.maker, pc.speed, pc.price
 FROM product prod
 JOIN pc on pc.model = prod.model) Misha,
(SELECT color, type, price
 FROM printer) Tanya,
(SELECT model, color, type, price
 FROM printer) Vitya,
(SELECT model, ram, screen
 FROM laptop) Olya,
(SELECT model, speed, ram, hd, price
 FROM pc) Kostya
WHERE
Dima.maker = Misha.maker and
Tanya.type <> Vitya.type and
Tanya.color = Vitya.color and
Dima.screen = Olya.screen+3 and
Misha.price = 4*Tanya.price and
stuff(Vitya.model, 3, 1, '') = stuff(Olya.model, 3, 1, '') and
Kostya.speed = Misha.speed and Kostya.hd = Dima.hd and Kostya.ram = Olya.ram and
Kostya.price = Vitya.price

