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


--8 почти решение
SELECT DISTINCT maker from Product
WHERE maker NOT IN
(SELECT DISTINCT maker from Product
INNER JOIN Laptop ON Laptop.model=Product.model)
AND maker IN 
(SELECT DISTINCT maker from Product
INNER JOIN PC ON PC.model=Product.model)

--8 
SELECT DISTINCT maker
FROM product
WHERE type = 'pc'
EXCEPT
SELECT DISTINCT product.maker
FROM product
Where type = 'laptop'


