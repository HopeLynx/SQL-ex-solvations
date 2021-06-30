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
