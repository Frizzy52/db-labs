# Лабораторна робота 01
## Робота з СУБД PostgreSQL та основи SQL

**Виконав:** Діма Чусов

## 1. Мета роботи

Ознайомлення з основами роботи із реляційними базами даних, встановлення з'єднання з хмарною СУБД, дослідження структури бази даних та виконання базових SQL-запитів для отримання інформації.


## 2. Рівень 1

### 2.1. Основні запити SELECT

**Запит 1.** Отримати всі записи з таблиці `customers`.

```sql
-- Символ * означає «усі стовпці»
SELECT * FROM customers;
```

![Результат запиту 1](screenshots/q01.png)

**Запит 2.** Вивести тільки назви товарів і їхні ціни з таблиці `products`.

```sql
-- Вибираємо лише два потрібні стовпці
SELECT product_name, unit_price
FROM products;
```

![Результат запиту 2](screenshots/q02.png)

**Запит 3.** Показати контактні дані всіх співробітників (ім'я, прізвище, телефон, електронна пошта).

```sql
-- Контактні дані з таблиці співробітників
SELECT first_name, last_name, phone, email
FROM employees;
```

![Результат запиту 3](screenshots/q03.png)

### 2.2. Прості умови WHERE

**Запит 4.** Знайти всіх клієнтів з міста Київ.

```sql
-- Фільтр за точним збігом міста
SELECT *
FROM customers
WHERE city = 'Київ';
```

![Результат запиту 4](screenshots/q04.png)

**Запит 5.** Вивести товари, які коштують більше 25000 грн.

```sql
-- Строго більше 25000 (сама ціна 25000 не входить)
SELECT product_name, unit_price
FROM products
WHERE unit_price > 25000;
```

![Результат запиту 5](screenshots/q05.png)

**Запит 6.** Показати всі замовлення зі статусом 'delivered'.

```sql
-- Лише доставлені замовлення
SELECT *
FROM orders
WHERE status = 'delivered';
```

![Результат запиту 6](screenshots/q06.png)

**Запит 7.** Знайти співробітників, які працюють у відділі продажів (посада містить слово «продаж»).

```sql
-- ILIKE не розрізняє великі й малі літери, % означає будь-які символи
SELECT first_name, last_name, position
FROM employees
WHERE position ILIKE '%продаж%';
```

![Результат запиту 7](screenshots/q07.png)

### 2.3. Базове сортування ORDER BY

**Запит 8.** Відсортувати товари за зростанням ціни.

```sql
-- ASC (за зростанням) діє за замовчуванням
SELECT product_name, unit_price
FROM products
ORDER BY unit_price ASC;
```

![Результат запиту 8](screenshots/q08.png)

**Запит 9.** Показати клієнтів в алфавітному порядку за іменем контактної особи.

```sql
SELECT contact_name, city
FROM customers
ORDER BY contact_name ASC;
```

![Результат запиту 9](screenshots/q09.png)

**Запит 10.** Вивести замовлення від найновіших до найстаріших.

```sql
-- DESC (за спаданням): спочатку найпізніша дата
SELECT *
FROM orders
ORDER BY order_date DESC;
```

![Результат запиту 10](screenshots/q10.png)

### 2.4. Обмеження результатів LIMIT

**Запит 11.** Показати перші 10 найдорожчих товарів.

```sql
-- Спочатку сортуємо за ціною від більшої до меншої, потім беремо 10 рядків
SELECT product_name, unit_price
FROM products
ORDER BY unit_price DESC
LIMIT 10;
```

![Результат запиту 11](screenshots/q11.png)

**Запит 12.** Вивести 5 останніх замовлень (за датою).

```sql
SELECT *
FROM orders
ORDER BY order_date DESC
LIMIT 5;
```

![Результат запиту 12](screenshots/q12.png)

**Запит 13.** Отримати перших 8 клієнтів в алфавітному порядку.

```sql
SELECT contact_name, city
FROM customers
ORDER BY contact_name ASC
LIMIT 8;
```

![Результат запиту 13](screenshots/q13.png)
