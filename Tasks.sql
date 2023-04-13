

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

Задание 14.
Найдите класс, имя и страну для кораблей из таблицы Ships, имеющих не менее 10 орудий.

SELECT Ships.class,Ships.name, Classes.country  FROM Classes 
INNER JOIN Ships on Classes.class = Ships.class
WHERE  Classes.numGuns >= 10

Задание 15.
Найдите размеры жестких дисков, совпадающих у двух и более PC. Вывести: HD

SELECT  PC.hd    FROM PC
GROUP BY PC.hd
HAVING COUNT(PC.hd) >=2

Задание: 16 
Найдите пары моделей PC, имеющих одинаковые скорость и RAM. В результате каждая пара указывается только один раз, т.е. (i,j), 
но не (j,i), Порядок вывода: модель с большим номером, модель с меньшим номером, скорость и RAM.

SELECT DISTINCT result1.model, result2.model, result1.speed, result1.ram  FROM PC AS result1, PC AS result2
WHERE result1.speed = result2.speed AND result1.ram = result2.ram AND result1.model <> result2.model AND result1.model > result2.model
