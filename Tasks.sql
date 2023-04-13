

Задание 6
Для каждого производителя, выпускающего ПК-блокноты c объёмом жесткого диска не менее 10 Гбайт, найти скорости таких ПК-блокнотов. Вывод: производитель, скорость.

SELECT DISTINCT Product.maker, Laptop.speed FROM Product 
RIGHT JOIN Laptop on Product.model = Laptop.model
WHERE Product.type = 'Laptop' and Laptop.hd >= 10

Задание 7.
Найдите номера моделей и цены всех имеющихся в продаже продуктов (любого типа) производителя B (латинская буква).

SELECT DISTINCT Product.model, PC.price
FROM Product INNER JOIN   
     PC ON PC.model = Product.model
WHERE Product.maker = 'B'
UNION
SELECT DISTINCT Product.model, Laptop.price
FROM Product INNER JOIN   
     Laptop ON Laptop.model = Product.model
WHERE Product.maker = 'B'
UNION
SELECT DISTINCT Product.model,Printer.price
FROM Product INNER JOIN 
Printer on Printer.model = Product.model
WHERE Product.maker = 'B'
ORDER BY Product.model

Задание 8
Найдите производителя, выпускающего ПК, но не ПК-блокноты.

SELECT DISTINCT Product.maker from Product
WHERE Product.type ='PC'
EXCEPT
SELECT DISTINCT Product.maker from Product
WHERE Product.type ='Laptop'
