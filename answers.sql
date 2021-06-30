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

