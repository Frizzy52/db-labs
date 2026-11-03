-- Лабораторна робота №01. PostgreSQL та основи SQL
-- Виконав: Діма Чусов
-- Рівень 2. Запити призначені для навчальної БД TechnoMart.

-- =========================================================
-- РІВЕНЬ 1. SELECT
-- =========================================================

-- 1. Усі записи клієнтів.
SELECT * FROM customers;

-- 2. Назви товарів та ціни.
SELECT product_name, unit_price FROM products;

-- 3. Контактні дані співробітників.
SELECT first_name, last_name, phone, email FROM employees;

-- WHERE
-- 4. Клієнти з Києва.
SELECT * FROM customers WHERE city = 'Київ';

-- 5. Товари дорожчі за 25000 грн.
SELECT * FROM products WHERE unit_price > 25000;

-- 6. Доставлені замовлення.
SELECT * FROM orders WHERE status = 'delivered';

-- 7. Працівники відділу продажів.
SELECT * FROM employees WHERE position ILIKE '%продаж%';

-- ORDER BY
-- 8. Товари від дешевших до дорожчих.
SELECT * FROM products ORDER BY unit_price ASC;

-- 9. Клієнти за ім'ям контактної особи.
SELECT * FROM customers ORDER BY contact_name ASC;

-- 10. Замовлення від найновіших до найстаріших.
SELECT * FROM orders ORDER BY order_date DESC;

-- LIMIT
-- 11. Десять найдорожчих товарів.
SELECT * FROM products ORDER BY unit_price DESC LIMIT 10;

-- 12. П'ять останніх замовлень.
SELECT * FROM orders ORDER BY order_date DESC LIMIT 5;

-- 13. Перші вісім клієнтів за алфавітом.
SELECT * FROM customers ORDER BY contact_name ASC LIMIT 8;

-- =========================================================
-- РІВЕНЬ 2. LIKE
-- =========================================================

-- 14. Клієнти, ім'я яких починається на «Іван».
SELECT * FROM customers WHERE contact_name LIKE 'Іван%';

-- 15. Товари, у назві яких є phone або телефон.
SELECT * FROM products
WHERE product_name ILIKE '%phone%' OR product_name ILIKE '%телефон%';

-- 16. Власний LIKE: назви товарів починаються на Samsung.
SELECT * FROM products WHERE product_name ILIKE 'Samsung%';

-- 17. Власний LIKE: email клієнтів закінчується на gmail.com.
SELECT * FROM customers WHERE email ILIKE '%@gmail.com';

-- 18. Власний LIKE: прізвище/контактне ім'я містить «енко».
SELECT * FROM customers WHERE contact_name ILIKE '%енко%';

-- Логіка: ці запити демонструють пошук за початком, кінцем і фрагментом рядка.

-- =========================================================
-- AND, OR, NOT
-- =========================================================

-- 19. Товари дорожчі за 15000 і дешевші за 50000 грн.
SELECT * FROM products
WHERE unit_price > 15000 AND unit_price < 50000;

-- 20. Юридичні особи з Києва або Львова.
SELECT * FROM customers
WHERE city IN ('Київ', 'Львів') AND customer_type = 'company';

-- 21. Власний: активні товари, що є на складі.
SELECT * FROM products
WHERE NOT discontinued AND units_in_stock > 0;

-- 22. Власний: замовлення доставлено або перебуває в обробці.
SELECT * FROM orders
WHERE status = 'delivered' OR status = 'processing';

-- 23. Власний: клієнти не з Києва та з указаною електронною адресою.
SELECT * FROM customers
WHERE city <> 'Київ' AND email IS NOT NULL;

-- 24. Власний: товари не з категорії 1 та ціною до 20000 грн.
SELECT * FROM products
WHERE NOT category_id = 1 AND unit_price <= 20000;

-- =========================================================
-- IN, BETWEEN, IS NULL / IS NOT NULL
-- =========================================================

-- 25. Клієнти з Києва, Харкова, Одеси або Дніпра.
SELECT * FROM customers
WHERE city IN ('Київ', 'Харків', 'Одеса', 'Дніпро');

-- 26. Товари в діапазоні 10000–30000 грн.
SELECT * FROM products
WHERE unit_price BETWEEN 10000 AND 30000;

-- 27. Власний IN: замовлення з обраними статусами.
SELECT * FROM orders
WHERE status IN ('delivered', 'processing', 'shipped');

-- 28. Власний IN: товари з категорій 1, 2 або 3.
SELECT * FROM products
WHERE category_id IN (1, 2, 3);

-- 29. Власний BETWEEN: замовлення за 2024 рік.
SELECT * FROM orders
WHERE order_date BETWEEN '2024-01-01' AND '2024-12-31';

-- 30. Власний BETWEEN: товари в нижчому ціновому сегменті.
SELECT * FROM products
WHERE unit_price BETWEEN 1000 AND 10000;

-- 31. Клієнти без назви компанії.
SELECT * FROM customers WHERE company_name IS NULL;

-- 32. Клієнти із заповненою назвою компанії.
SELECT * FROM customers WHERE company_name IS NOT NULL;

-- =========================================================
-- КОМБІНУВАННЯ УМОВ (5 самостійних запитів)
-- =========================================================

-- 33. Активні товари середньої ціни, що є на складі.
-- Бізнес-логіка: знайти доступні для продажу товари без знятих з виробництва позицій.
SELECT product_name, unit_price, units_in_stock
FROM products
WHERE unit_price BETWEEN 10000 AND 40000
  AND units_in_stock > 0
  AND NOT discontinued
  AND product_name NOT ILIKE '%чохол%'
ORDER BY unit_price DESC;

-- 34. Клієнти з великих міст, які мають email і не є тестовими.
-- Бізнес-логіка: відібрати придатні для комунікації клієнтські контакти.
SELECT contact_name, city, email
FROM customers
WHERE city IN ('Київ', 'Львів', 'Харків', 'Одеса')
  AND email IS NOT NULL
  AND contact_name NOT ILIKE '%тест%'
ORDER BY city, contact_name;

-- 35. Товари Samsung або Apple у заданому діапазоні цін.
-- Бізнес-логіка: порівняти популярні бренди у середньому сегменті.
SELECT product_name, unit_price
FROM products
WHERE (product_name ILIKE '%Samsung%' OR product_name ILIKE '%Apple%')
  AND unit_price BETWEEN 10000 AND 50000
ORDER BY unit_price DESC;

-- 36. Замовлення за період, що мають один із потрібних статусів.
-- Бізнес-логіка: переглянути завершені або відправлені замовлення за період.
SELECT *
FROM orders
WHERE order_date BETWEEN '2024-01-01' AND '2024-12-31'
  AND status IN ('delivered', 'shipped')
ORDER BY order_date DESC;

-- 37. Клієнти не з Києва/Львова, але з відомим телефоном та email.
-- Бізнес-логіка: сформувати список контактів для регіональної кампанії.
SELECT contact_name, city, phone, email
FROM customers
WHERE city NOT IN ('Київ', 'Львів')
  AND phone IS NOT NULL
  AND email IS NOT NULL
ORDER BY city, contact_name;

-- =========================================================
-- СОРТУВАННЯ ЗА КІЛЬКОМА ПОЛЯМИ (3 запити)
-- =========================================================

-- 38. Спочатку категорія, у ній — дорожчі товари.
SELECT product_name, category_id, unit_price
FROM products
ORDER BY category_id ASC, unit_price DESC;

-- 39. Клієнти за типом, містом та контактним ім'ям.
SELECT contact_name, customer_type, city
FROM customers
ORDER BY customer_type ASC, city ASC, contact_name ASC;

-- 40. Замовлення за статусом, а потім від найновіших.
SELECT order_id, status, order_date
FROM orders
ORDER BY status ASC, order_date DESC;

-- OFFSET / пагінація (2 запити)
-- 41. Друга сторінка клієнтів: 10 записів на сторінці.
SELECT * FROM customers
ORDER BY contact_name
LIMIT 10 OFFSET 10;

-- 42. Третя сторінка товарів: 10 записів на сторінці.
SELECT * FROM products
ORDER BY product_name
LIMIT 10 OFFSET 20;

-- Формула OFFSET = (номер_сторінки - 1) * розмір_сторінки.
