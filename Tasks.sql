Задание1
Найдите номер модели, скорость и размер жесткого диска для всех ПК стоимостью менее 500 дол. Вывести: model, speed и hd

SELECT PC.model, PC.speed, PC.hd FROM PC
WHERE PC.price < 500

Задание2
Найдите производителей принтеров. Вывести: maker
SELECT DISTINCT Product.maker  FROM Product
WHERE type = 'Printer'

-- или можно использовать GROUP BY maker--

SELECT Product.maker  FROM Product
WHERE type = 'Printer'
GROUP BY Product.maker


Задание 3
Найдите номер модели, объем памяти и размеры экранов ПК-блокнотов, цена которых превышает 1000 дол.

SELECT model,ram,screen FROM Laptop
WHERE Laptop.price > 1000

Задание 4
Найдите все записи таблицы Printer для цветных принтеров.

SELECT * FROM Printer
WHERE Printer.color = 'y'

Задание5

Найдите номер модели, скорость и размер жесткого диска ПК, имеющих 12x или 24x CD и цену менее 600 дол

SELECT model, speed, hd FROM PC
WHERE cd IN ('12x','24x')  AND price < 600


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

Задание 9
Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker

SELECT Maker FROM Product
INNER JOIN PC ON PC.model = Product.model
WHERE PC.speed >= 450
GROUP BY Maker


Задание 11.
Найдите среднюю скорость ПК

SELECT AVG(PC.speed) as avg_speed_pc FROM PC
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

Задание 17
Найдите модели ПК-блокнотов, скорость которых меньше скорости каждого из ПК.
Вывести: type, model, speed

SELECT DISTINCT Product.type, Laptop.model, Laptop.speed
FROM Product

INNER JOIN Laptop on Product.model = Laptop.model
WHERE speed < ALL (SELECT speed
 FROM PC
 )
Задание 18
Найдите производителей самых дешевых цветных принтеров. Вывести: maker, price

SELECT DISTINCT maker, price
FROM Printer INNER JOIN Product
ON Printer.model = Product.model
WHERE Printer.color ='y' and Printer.price = (SELECT MIN(price)
FROM printer WHERE color = 'y')


Задание 20
Найдите производителей, выпускающих по меньшей мере три различных модели ПК. Вывести: Maker, число моделей ПК.

SELECT Product.maker, COUNT(Product.model) from Product
WHERE Product.type ='PC'
GROUP BY Product.maker
HAVING COUNT(Product.model) >=3

Задание 23

Найдите производителей, которые производили бы как ПК
со скоростью не менее 750 МГц, так и ПК-блокноты со скоростью не менее 750 МГц.
Вывести: Maker

SELECT DISTINCT Product.Maker FROM Product
INNER JOIN PC on Product.model = PC.model
WHERE PC.speed >= 750 AND Maker IN (SELECT DISTINCT Product.Maker from Product
INNER JOIN Laptop on Product.model = Laptop.model
WHERE Laptop.speed >=750)

Задание 24
Перечислите номера моделей любых типов, имеющих самую высокую цену по всей имеющейся в базе данных продукции.

select model from (

select PC.model,PC.price,'PC' as type from PC
UNION
select Laptop.model,Laptop.price,'Laptop' as type from Laptop
UNION
select Printer.model,Printer.price,'Printer' as type from Printer) as fullCatalog

where fullCatalog.price = (
select MAX(price) from (
select PC.model,PC.price,'PC' as type from PC
UNION
select Laptop.model,Laptop.price,'Laptop' as type from Laptop
UNION
select Printer.model,Printer.price,'Printer' as type from Printer
) as max_price
)

Задание 25
Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК,
 имеющих наименьший объем RAM. Вывести: Maker
SELECT DISTINCT maker
FROM Product
WHERE model IN (
    SELECT model FROM PC
    WHERE ram = (
      SELECT MIN(ram)
      FROM PC
     )
AND speed = (
            SELECT MAX(speed)
           FROM PC WHERE ram = (
         SELECT MIN(ram)
       FROM PC
                         )
            )
              )
AND
maker IN (
SELECT maker
FROM Product
WHERE type='printer'
         )

Задание 26
Найдите среднюю цену ПК и ПК-блокнотов, выпущенных производителем A (латинская буква). Вывести: одна общая средняя цена.

SELECT AVG(result.price) FROM (SELECT PC.code, PC.price,Product.maker, Product.model,Product.type  from PC
 JOIN Product ON (PC.model = Product.model and Product.type='PC' )
WHERE Product.maker = 'A'
UNION 
SELECT Laptop.code, Laptop.price,Product.maker,Product.model, Product.type  FROM Laptop
 JOIN Product ON (Laptop.model = Product.model and Product.type='Laptop' )
WHERE Product.maker = 'A') AS result


Задание 27
Найдите средний размер диска ПК каждого из тех производителей, которые выпускают и принтеры. Вывести: maker, средний размер HD.
SELECT Product.maker, AVG(PC.hd) FROM PC
JOIN Product ON PC.model = Product.model AND Product.type = 'PC'
WHERE Product.maker IN ( SELECT DISTINCT maker FROM Product where Product.type = 'Printer')
GROUP BY Product.maker

Задание 28
Используя таблицу Product, определить количество производителей, выпускающих по одной модели.
SELECT COUNT(*) FROM (
SELECT Product.maker, COUNT(model) AS countModel FROM Product
GROUP BY Product.maker
HAVING COUNT(model)=1  
) AS result2

Задание 34
По Вашингтонскому международному договору от начала 1922 г. запрещалось строить линейные корабли водоизмещением более 35 тыс.тонн. 
Укажите корабли, нарушившие этот договор (учитывать только корабли c известным годом спуска на воду). 
Вывести названия кораблей.

SELECT DISTINCT Ships.name from Classes, Ships
WHERE Ships.launched >=1922 and Classes.type='bb' AND Classes.displacement > 35000 AND Ships.class = Classes.class

Задание 35
В таблице Product найти модели, которые состоят только из цифр или только из латинских букв (A-Z, без учета регистра).
Вывод: номер модели, тип модели.

SELECT model,type FROM Product
WHERE Product.model NOT like '%[^A-Za-z]%' OR Product.model NOT like '%[^0-9]%'

Задание 36
Перечислите названия головных кораблей, имеющихся в базе данных (учесть корабли в Outcomes).
SELECT  Classes.class FROM Classes
INNER JOIN Outcomes ON Classes.class = Outcomes.ship
UNION
SELECT Classes.class FROM Classes
INNER JOIN Ships on Classes.class = Ships.name
GROUP BY Classes.class

Задание 37
Найдите классы, в которые входит только один корабль из базы данных (учесть также корабли в Outcomes).
SELECT  result.class AS count_result  FROM (SELECT Classes.class, Ships.name   FROM Classes
INNER JOIN Ships ON Classes.class = Ships.class
UNION
SELECT Classes.class, Outcomes.ship  FROM Outcomes, Classes
WHERE Outcomes.ship  = Classes.class) AS result
GROUP BY result.class
HAVING COUNt(result.name) = 1

Задание 40
Найти производителей, которые выпускают более одной модели, при этом все выпускаемые производителем модели являются продуктами одного типа.
Вывести: maker, type
SELECT Product.maker, Product.type FROM (SELECT  result.maker FROM
  (SELECT Product.maker, Product.type, COUNT(Product.type) AS typeCount FROM Product
GROUP BY Product.maker, Product.type) AS result
GROUP BY result.maker
HAVING COUNT(result.maker) = 1) AS makers
INNER JOIN Product ON makers.maker = Product.maker
GROUP BY Product.maker, Product.type
HAVING COUNT(Product.model) >1




