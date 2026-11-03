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

## 3. Рівень 2

### 3.1. Пошук за зразком LIKE

**Запит 14.** Знайти всіх клієнтів, чиї імена починаються на «Іван».

```sql
-- Шаблон 'Іван%': слово «Іван» на початку, далі будь-що
SELECT contact_name, city
FROM customers
WHERE contact_name LIKE 'Іван%';
```

![Результат запиту 14](screenshots/q14.png)

**Запит 15.** Вивести товари, в назві яких є слово «phone» або «телефон».

```sql
-- ILIKE ігнорує регістр, тому знайде і «Phone», і «PHONE»
SELECT product_name, unit_price
FROM products
WHERE product_name ILIKE '%phone%'
   OR product_name ILIKE '%телефон%';
```

![Результат запиту 15](screenshots/q15.png)

**Запит 16.** Самостійно (збіг наприкінці): клієнти, прізвище яких закінчується на «енко».

```sql
-- Шаблон '%енко': будь-що спочатку, «енко» наприкінці
SELECT contact_name, city
FROM customers
WHERE contact_name LIKE '%енко'
ORDER BY contact_name;
```

**Бізнес-логіка:** Багато українських прізвищ мають закінчення «-енко». Запит швидко виділяє таку групу клієнтів, наприклад для персоналізованої розсилки.

![Результат запиту 16](screenshots/q16.png)

**Запит 17.** Самостійно (збіг усередині): клієнти, в імені яких є фрагмент «Олекс».

```sql
-- Шаблон '%Олекс%': фрагмент може стояти в будь-якому місці
SELECT contact_name, city
FROM customers
WHERE contact_name LIKE '%Олекс%';
```

**Бізнес-логіка:** Фрагмент «Олекс» охоплює імена Олексій, Олександр, Олександра. Так менеджер знаходить усіх клієнтів з подібними іменами, не знаючи точного написання.

![Результат запиту 17](screenshots/q17.png)

**Запит 18.** Самостійно (збіг на початку): товари, назва яких починається на «Samsung».

```sql
-- Шаблон 'Samsung%': лише товари цього виробника
SELECT product_name, unit_price
FROM products
WHERE product_name LIKE 'Samsung%'
ORDER BY unit_price DESC;
```

**Бізнес-логіка:** Відбираємо весь асортимент одного виробника для аналізу його частки в магазині та цінової політики.

![Результат запиту 18](screenshots/q18.png)

### 3.2. Логічні оператори AND, OR, NOT

**Запит 19.** Знайти товари дорожчі за 15000 грн і дешевші за 50000 грн.

```sql
-- Обидві умови мають виконуватися одночасно
SELECT product_name, unit_price
FROM products
WHERE unit_price > 15000
  AND unit_price < 50000;
```

![Результат запиту 19](screenshots/q19.png)

**Запит 20.** Вивести клієнтів з Києва або Львова, які є юридичними особами.

```sql
-- Дужки обов'язкові: спочатку обираємо місто, потім застосовуємо AND
SELECT contact_name, city, customer_type
FROM customers
WHERE (city = 'Київ' OR city = 'Львів')
  AND customer_type = 'company';
```

![Результат запиту 20](screenshots/q20.png)

**Запит 21.** Самостійно: доступні бюджетні товари (дешевші за 10000 грн, є на складі, не зняті з виробництва).

```sql
-- AND та NOT разом: три умови одночасно
SELECT product_name, unit_price, units_in_stock
FROM products
WHERE unit_price < 10000
  AND units_in_stock > 0
  AND NOT discontinued
ORDER BY unit_price;
```

**Бізнес-логіка:** Список товарів, які можна одразу рекомендувати покупцю з обмеженим бюджетом: вони дешеві, фізично є в наявності й актуальні.

![Результат запиту 21](screenshots/q21.png)

**Запит 22.** Самостійно: юридичні особи не з Києва.

```sql
-- NOT: виключаємо столицю, залишаємо компанії з інших міст
SELECT contact_name, city, customer_type
FROM customers
WHERE customer_type = 'company'
  AND NOT city = 'Київ';
```

**Бізнес-логіка:** Відділ продажів може окремо працювати з регіональними корпоративними клієнтами, які не охоплені столичними менеджерами.

![Результат запиту 22](screenshots/q22.png)

**Запит 23.** Самостійно: замовлення, які ще не доставлені й не відправлені.

```sql
-- Статус не 'delivered' І дата відправлення порожня
SELECT order_id, order_date, status
FROM orders
WHERE status <> 'delivered'
  AND shipped_date IS NULL
ORDER BY order_date;
```

**Бізнес-логіка:** Це черга замовлень, що чекають на відправлення. Найстарші потрібно обробити першими, щоб не порушити терміни.

![Результат запиту 23](screenshots/q23.png)

**Запит 24.** Самостійно: співробітники, які мають керівника і чия посада не містить слова «директор».

```sql
SELECT first_name, last_name, position
FROM employees
WHERE reports_to IS NOT NULL
  AND position NOT ILIKE '%директор%';
```

**Бізнес-логіка:** Показує рядовий і середній персонал без вищого керівництва, наприклад для внутрішнього опитування працівників.

![Результат запиту 24](screenshots/q24.png)

### 3.3. Оператори IN, BETWEEN, IS NULL

**Запит 25.** Вивести клієнтів з міст Київ, Харків, Одеса, Дніпро.

```sql
-- IN замінює ланцюжок із чотирьох OR
SELECT contact_name, city
FROM customers
WHERE city IN ('Київ', 'Харків', 'Одеса', 'Дніпро')
ORDER BY city, contact_name;
```

![Результат запиту 25](screenshots/q25.png)

**Запит 26.** Знайти товари в ціновому діапазоні від 10000 до 30000 грн.

```sql
-- BETWEEN включає обидві межі
SELECT product_name, unit_price
FROM products
WHERE unit_price BETWEEN 10000 AND 30000
ORDER BY unit_price;
```

![Результат запиту 26](screenshots/q26.png)

**Запит 27.** Самостійно (IN, 1): клієнти із західних міст Львів та Луцьк.

```sql
SELECT contact_name, city
FROM customers
WHERE city IN ('Львів', 'Луцьк');
```

**Бізнес-логіка:** Регіональна група клієнтів для планування відкриття пункту видачі на заході країни.

![Результат запиту 27](screenshots/q27.png)

**Запит 28.** Самостійно (IN, 2): товари перших трьох категорій.

```sql
SELECT product_name, category_id, unit_price
FROM products
WHERE category_id IN (1, 2, 3)
ORDER BY category_id, product_name;
```

**Бізнес-логіка:** Вибірка основних категорій для вітрини головної сторінки магазину.

![Результат запиту 28](screenshots/q28.png)

**Запит 29.** Самостійно (BETWEEN, 1): товари в діапазоні 5000-15000 грн.

```sql
SELECT product_name, unit_price
FROM products
WHERE unit_price BETWEEN 5000 AND 15000
ORDER BY unit_price;
```

**Бізнес-логіка:** Середній нижній сегмент, найбільш масовий за попитом.

![Результат запиту 29](screenshots/q29.png)

**Запит 30.** Самостійно (BETWEEN, 2): замовлення за перше півріччя 2024 року.

```sql
SELECT order_id, order_date, status
FROM orders
WHERE order_date BETWEEN '2024-01-01' AND '2024-06-30'
ORDER BY order_date;
```

**Бізнес-логіка:** Вибірка за півріччя потрібна для квартального й піврічного звіту про продажі.

![Результат запиту 30](screenshots/q30.png)

**Запит 31.** Самостійно (IS NULL): клієнти без назви компанії (фізичні особи).

```sql
-- Порівняння = NULL не працює, тільки IS NULL
SELECT contact_name, city
FROM customers
WHERE company_name IS NULL;
```

**Бізнес-логіка:** Відділяє роздрібних покупців від корпоративних, бо в них різні умови обслуговування й оплати.

![Результат запиту 31](screenshots/q31.png)

**Запит 32.** Самостійно (IS NOT NULL): замовлення, які вже відправлені.

```sql
SELECT order_id, order_date, shipped_date
FROM orders
WHERE shipped_date IS NOT NULL
ORDER BY shipped_date DESC;
```

**Бізнес-логіка:** Історія відправлених замовлень допомагає перевіряти роботу складу й логістики.

![Результат запиту 32](screenshots/q32.png)

### 3.4. Комбінування умов (5 власних складних запитів)

**Запит 33.** Самостійно (LIKE + AND/OR): товари Samsung або Apple, які є на складі.

```sql
SELECT product_name, unit_price, units_in_stock
FROM products
WHERE (product_name ILIKE '%Samsung%' OR product_name ILIKE '%Apple%')
  AND units_in_stock > 0
ORDER BY unit_price DESC;
```

**Бізнес-логіка:** Два найпопулярніші бренди, але лише ті позиції, які реально можна продати зараз.

![Результат запиту 33](screenshots/q33.png)

**Запит 34.** Самостійно (BETWEEN + IN): товари від 10000 до 40000 грн у категоріях 1 та 2.

```sql
SELECT product_name, category_id, unit_price
FROM products
WHERE unit_price BETWEEN 10000 AND 40000
  AND category_id IN (1, 2)
ORDER BY category_id, unit_price;
```

**Бізнес-логіка:** Середній ціновий сегмент двох ключових категорій для підготовки акційної добірки.

![Результат запиту 34](screenshots/q34.png)

**Запит 35.** Самостійно (IN + IS NOT NULL + LIKE): клієнти великих міст із поштою Gmail.

```sql
SELECT contact_name, city, email
FROM customers
WHERE city IN ('Київ', 'Харків', 'Одеса', 'Дніпро')
  AND email IS NOT NULL
  AND email LIKE '%@gmail.com';
```

**Бізнес-логіка:** Аудиторія для електронної розсилки, де гарантовано є адреса пошти потрібного сервісу.

![Результат запиту 35](screenshots/q35.png)

**Запит 36.** Самостійно (BETWEEN + статус + NULL): доставлені замовлення 2024 року з датою відправлення.

```sql
SELECT order_id, order_date, shipped_date, status
FROM orders
WHERE order_date BETWEEN '2024-01-01' AND '2024-12-31'
  AND status = 'delivered'
  AND shipped_date IS NOT NULL;
```

**Бізнес-логіка:** Успішно виконані замовлення за рік: основа для розрахунку реальної виручки й середніх термінів доставки.

![Результат запиту 36](screenshots/q36.png)

**Запит 37.** Самостійно (LIKE + IS NOT NULL + AND): співробітники-менеджери, яких можна знайти за телефоном.

```sql
SELECT first_name, last_name, position, phone
FROM employees
WHERE position ILIKE '%менеджер%'
  AND phone IS NOT NULL
  AND reports_to IS NOT NULL;
```

**Бізнес-логіка:** Контактний список менеджерів для оперативного зв'язку, без вищого керівництва та записів без телефону.

![Результат запиту 37](screenshots/q37.png)

### 3.5. Складне сортування та пагінація

**Запит 38.** Самостійно (сортування, 1): товари за категорією зростанням, всередині категорії за ціною спаданням.

```sql
SELECT product_name, category_id, unit_price
FROM products
ORDER BY category_id ASC, unit_price DESC;
```

**Бізнес-логіка:** У кожній категорії зверху найдорожчі товари: зручно для каталогу «від флагманів до бюджетних».

![Результат запиту 38](screenshots/q38.png)

**Запит 39.** Самостійно (сортування, 2): клієнти за типом, містом та іменем.

```sql
SELECT contact_name, customer_type, city
FROM customers
ORDER BY customer_type, city, contact_name;
```

**Бізнес-логіка:** Впорядкований список для обдзвону: групи за типом клієнта, потім по містах, далі за алфавітом.

![Результат запиту 39](screenshots/q39.png)

**Запит 40.** Самостійно (сортування, 3): замовлення за статусом та датою (нові зверху).

```sql
SELECT order_id, status, order_date
FROM orders
ORDER BY status ASC, order_date DESC;
```

**Бізнес-логіка:** Менеджер бачить замовлення згруповані за статусом, у кожній групі першими йдуть найновіші.

![Результат запиту 40](screenshots/q40.png)

**Запит 41.** Самостійно (OFFSET, 1): друга сторінка товарів по 10 штук.

```sql
-- Формула: OFFSET = (номер_сторінки - 1) * розмір_сторінки = (2 - 1) * 10
SELECT product_name, unit_price
FROM products
ORDER BY product_name
LIMIT 10 OFFSET 10;
```

**Бізнес-логіка:** Так працює сторінка №2 каталогу інтернет-магазину: пропускаємо 10 товарів першої сторінки й показуємо наступні 10.

![Результат запиту 41](screenshots/q41.png)

**Запит 42.** Самостійно (OFFSET, 2): третя сторінка клієнтів по 8 записів.

```sql
-- OFFSET = (3 - 1) * 8 = 16
SELECT contact_name, city
FROM customers
ORDER BY contact_name
LIMIT 8 OFFSET 16;
```

**Бізнес-логіка:** Пагінація в адмін-панелі: менеджер гортає великий список клієнтів невеликими порціями.

![Результат запиту 42](screenshots/q42.png)

## 4. Рівень 3

### 4.1. Складні комбінації LIKE з логічними операторами

**Запит 43.** Знайти товари, в назві яких є «Samsung» або «Apple», але немає слова «чохол».

```sql
-- Дужки групують OR, NOT LIKE виключає аксесуари
SELECT product_name, unit_price
FROM products
WHERE (product_name ILIKE '%Samsung%' OR product_name ILIKE '%Apple%')
  AND product_name NOT ILIKE '%чохол%'
ORDER BY unit_price DESC;
```

![Результат запиту 43](screenshots/q43.png)

**Запит 44.** Самостійно: iPhone без чохлів і захисного скла.

```sql
SELECT product_name, unit_price
FROM products
WHERE product_name ILIKE '%iphone%'
  AND product_name NOT ILIKE '%чохол%'
  AND product_name NOT ILIKE '%скло%';
```

**Бізнес-логіка:** Залишаємо самі смартфони й прибираємо дешеві аксесуари, які спотворюють аналіз цін.

![Результат запиту 44](screenshots/q44.png)

**Запит 45.** Самостійно: товари Samsung або Xiaomi, крім кабелів.

```sql
SELECT product_name, unit_price
FROM products
WHERE (product_name LIKE 'Samsung%' OR product_name LIKE 'Xiaomi%')
  AND product_name NOT ILIKE '%кабель%'
ORDER BY product_name;
```

**Бізнес-логіка:** Порівняння двох виробників за основними пристроями без дрібних комплектуючих.

![Результат запиту 45](screenshots/q45.png)

**Запит 46.** Самостійно: клієнти з прізвищами на «-енко» або «-чук», які не є тестовими записами.

```sql
SELECT contact_name, city
FROM customers
WHERE (contact_name LIKE '%енко' OR contact_name LIKE '%чук')
  AND contact_name NOT ILIKE '%тест%';
```

**Бізнес-логіка:** Типові українські закінчення прізвищ; виключення «тест» очищає вибірку від службових записів.

![Результат запиту 46](screenshots/q46.png)

**Запит 47.** Самостійно: ноутбуки дорожчі за 30000 грн.

```sql
SELECT product_name, unit_price
FROM products
WHERE (product_name ILIKE '%ноутбук%' OR product_name ILIKE '%laptop%')
  AND unit_price > 30000
ORDER BY unit_price DESC;
```

**Бізнес-логіка:** Прем'юм-сегмент ноутбуків; обидва слова («ноутбук» і «laptop») враховують різні варіанти назв у каталозі.

![Результат запиту 47](screenshots/q47.png)

### 4.2. Вкладені логічні умови

**Запит 48.** Знайти товари дорожчі за 20000 грн (категорії 1 або 2) АБО товари дешевші за 5000 грн будь-якої категорії.

```sql
SELECT product_name, category_id, unit_price
FROM products
WHERE (unit_price > 20000 AND (category_id = 1 OR category_id = 2))
   OR unit_price < 5000
ORDER BY unit_price DESC;
```

![Результат запиту 48](screenshots/q48.png)

**Запит 49.** Самостійно: різні цінові правила для різних категорій.

```sql
SELECT product_name, category_id, unit_price
FROM products
WHERE units_in_stock > 0
  AND (
        (category_id = 1 AND unit_price BETWEEN 10000 AND 30000)
     OR (category_id = 2 AND unit_price < 10000)
      );
```

**Бізнес-логіка:** У категорії 1 цікавить середній сегмент, у категорії 2 бюджетний: в кожної категорії своя цінова логіка.

![Результат запиту 49](screenshots/q49.png)

**Запит 50.** Самостійно: пріоритетні клієнти (корпоративні з Києва або приватні з поштою з інших міст).

```sql
SELECT contact_name, city, customer_type
FROM customers
WHERE (customer_type = 'company' AND city = 'Київ')
   OR (customer_type <> 'company' AND city <> 'Київ' AND email IS NOT NULL);
```

**Бізнес-логіка:** Два різні сценарії роботи: особисті зустрічі з київськими компаніями й віддалена комунікація з регіональними приватними клієнтами.

![Результат запиту 50](screenshots/q50.png)

**Запит 51.** Самостійно: проблемні й нові замовлення.

```sql
SELECT order_id, order_date, status, shipped_date
FROM orders
WHERE (status = 'delivered' AND order_date >= '2024-01-01')
   OR (status <> 'delivered' AND shipped_date IS NULL);
```

**Бізнес-логіка:** Об'єднує успішні нещодавні продажі та замовлення, що «зависли» без відправлення, для керівника відділу.

![Результат запиту 51](screenshots/q51.png)

### 4.3. Комплексні аналітичні запити

**Запит 52.** Самостійно: звіт про товари з шістьма умовами фільтрації одночасно.

```sql
SELECT
    product_name AS "Назва товару",
    unit_price AS "Ціна, грн",
    units_in_stock AS "На складі"
FROM products
WHERE unit_price BETWEEN 15000 AND 45000        -- 1) середній ціновий сегмент
  AND NOT discontinued                           -- 2) товар актуальний
  AND units_in_stock > 0                         -- 3) є в наявності
  AND product_name NOT ILIKE '%чохол%'           -- 4) не аксесуар
  AND category_id IN (1, 2, 3)                   -- 5) основні категорії
  AND description IS NOT NULL                    -- 6) є опис для картки товару
ORDER BY unit_price DESC
LIMIT 15;
```

**Бізнес-логіка:** Добірка товарів для головної сторінки: актуальні, наявні, з описом і в найпопулярнішому ціновому діапазоні.

![Результат запиту 52](screenshots/q52.png)

**Запит 53.** Самостійно: аналіз клієнтської бази з кількома критеріями та сегментацією.

```sql
SELECT
    contact_name,
    city,
    customer_type,
    CASE
        WHEN customer_type = 'company' AND city = 'Київ' THEN 'VIP корпоративний клієнт'
        WHEN customer_type = 'company' THEN 'Корпоративний клієнт'
        WHEN city IN ('Київ', 'Харків', 'Львів') THEN 'Клієнт великого міста'
        ELSE 'Регіональний клієнт'
    END AS сегмент
FROM customers
WHERE email IS NOT NULL                          -- є пошта для зв'язку
  AND phone IS NOT NULL                          -- є телефон
  AND contact_name NOT ILIKE '%тест%'            -- прибираємо тестові записи
ORDER BY customer_type DESC, city, contact_name;
```

**Бізнес-логіка:** Розподіляє клієнтів на сегменти, щоб для кожного обрати свій канал і тип пропозиції. Беруться лише ті, до кого реально можна достукатися.

![Результат запиту 53](screenshots/q53.png)

### 4.4. Дослідження даних та пошук закономірностей

#### Аналіз товарів за ціновими сегментами

**Запит 54.** Самостійно: кількість товарів у кожному ціновому сегменті.

```sql
SELECT
    CASE
        WHEN unit_price < 5000  THEN '1. Бюджетний (до 5000)'
        WHEN unit_price < 20000 THEN '2. Середній (5000-19999)'
        WHEN unit_price < 50000 THEN '3. Преміум (20000-49999)'
        ELSE '4. Люкс (від 50000)'
    END AS сегмент,
    COUNT(*) AS кількість_товарів
FROM products
GROUP BY сегмент
ORDER BY сегмент;
```

**Бізнес-логіка:** Показує структуру асортименту: який сегмент найбільший. Це база для рішень про закупівлі.

![Результат запиту 54](screenshots/q54.png)

**Запит 55.** Самостійно: три найдорожчі товари в сегменті «Люкс».

```sql
SELECT product_name, unit_price
FROM products
WHERE unit_price >= 50000
ORDER BY unit_price DESC
LIMIT 3;
```

**Бізнес-логіка:** Флагманські позиції: їх варто виділити в рекламі й тримати в кращих місцях вітрини.

![Результат запиту 55](screenshots/q55.png)

**Запит 56.** Самостійно: загальна вартість складських залишків за сегментами.

```sql
SELECT
    CASE
        WHEN unit_price < 20000 THEN 'Доступні (до 20000)'
        ELSE 'Дорогі (від 20000)'
    END AS сегмент,
    SUM(unit_price * units_in_stock) AS вартість_залишків
FROM products
GROUP BY сегмент;
```

**Бізнес-логіка:** Показує, в якому сегменті заморожено більше грошей на складі, а це важливо для фінансового планування.

![Результат запиту 56](screenshots/q56.png)

#### Географічний розподіл клієнтів

**Запит 57.** Самостійно: кількість клієнтів у кожному місті.

```sql
SELECT city, COUNT(*) AS кількість_клієнтів
FROM customers
GROUP BY city
ORDER BY кількість_клієнтів DESC;
```

**Бізнес-логіка:** Основна карта клієнтської бази: де найбільше покупців.

![Результат запиту 57](screenshots/q57.png)

**Запит 58.** Самостійно: міста, де є щонайменше 3 клієнти.

```sql
SELECT city, COUNT(*) AS кількість_клієнтів
FROM customers
GROUP BY city
HAVING COUNT(*) >= 3
ORDER BY кількість_клієнтів DESC;
```

**Бізнес-логіка:** Відсікає випадкові міста з одним-двома клієнтами й залишає ринки, що варто розвивати.

![Результат запиту 58](screenshots/q58.png)

**Запит 59.** Самостійно: кількість юридичних осіб за містами.

```sql
SELECT city, COUNT(*) AS кількість_компаній
FROM customers
WHERE customer_type = 'company'
GROUP BY city
ORDER BY кількість_компаній DESC;
```

**Бізнес-логіка:** Показує, де зосереджений корпоративний сегмент, щоб спрямувати туди менеджерів з B2B-продажів.

![Результат запиту 59](screenshots/q59.png)

**Запит 60.** Самостійно: п'ять міст з найбільшою кількістю клієнтів.

```sql
SELECT city, COUNT(*) AS кількість_клієнтів
FROM customers
GROUP BY city
ORDER BY кількість_клієнтів DESC
LIMIT 5;
```

**Бізнес-логіка:** Топ-5 міст для таргетованої реклами й відкриття нових пунктів видачі.

![Результат запиту 60](screenshots/q60.png)

#### Часові закономірності в замовленнях

**Запит 61.** Самостійно: кількість замовлень за роками та місяцями.

```sql
SELECT
    EXTRACT(YEAR FROM order_date)  AS рік,
    EXTRACT(MONTH FROM order_date) AS місяць,
    COUNT(*) AS кількість_замовлень
FROM orders
GROUP BY рік, місяць
ORDER BY рік, місяць;
```

**Бізнес-логіка:** Показує сезонність продажів: у які місяці попит зростає, щоб заздалегідь поповнювати склад.

![Результат запиту 61](screenshots/q61.png)

**Запит 62.** Самостійно: розподіл замовлень за днями тижня.

```sql
-- 0 = неділя, 1 = понеділок ... 6 = субота
SELECT
    EXTRACT(DOW FROM order_date) AS день_тижня,
    COUNT(*) AS кількість_замовлень
FROM orders
GROUP BY день_тижня
ORDER BY день_тижня;
```

**Бізнес-логіка:** Допомагає визначити, у які дні клієнти замовляють найбільше, і відповідно планувати зміни співробітників.

![Результат запиту 62](screenshots/q62.png)

**Запит 63.** Самостійно: кількість замовлень за статусами.

```sql
SELECT status, COUNT(*) AS кількість
FROM orders
GROUP BY status
ORDER BY кількість DESC;
```

**Бізнес-логіка:** Швидка картина стану виконання замовлень: скільки доставлено, скільки в процесі.

![Результат запиту 63](screenshots/q63.png)

### 4.5. Креативні запити

**Запит 64.** Самостійно: «заморожений капітал»: 10 позицій з найбільшою вартістю залишків.

```sql
SELECT
    product_name,
    unit_price,
    units_in_stock,
    unit_price * units_in_stock AS вартість_залишку
FROM products
WHERE units_in_stock > 0
ORDER BY вартість_залишку DESC
LIMIT 10;
```

**Бізнес-логіка:** Тут «лежать» найбільші гроші магазину. Такі товари варто просувати акціями в першу чергу.

![Результат запиту 64](screenshots/q64.png)

**Запит 65.** Самостійно: клієнти для обдзвону (є телефон, немає пошти).

```sql
SELECT contact_name, city, phone
FROM customers
WHERE email IS NULL
  AND phone IS NOT NULL
ORDER BY city;
```

**Бізнес-логіка:** Електронною поштою з цими клієнтами не зв'язатися, тому єдиний канал комунікації - дзвінок.

![Результат запиту 65](screenshots/q65.png)

**Запит 66.** Самостійно: товари з «психологічною» ціною, що закінчується на 999.

```sql
-- Перетворюємо число на текст і шукаємо шаблон
SELECT product_name, unit_price
FROM products
WHERE unit_price::text LIKE '%999'
ORDER BY unit_price;
```

**Бізнес-логіка:** Аналіз цінової політики: скільки товарів використовують маркетинговий прийом «999», бо ціна сприймається нижчою.

![Результат запиту 66](screenshots/q66.png)

**Запит 67.** Самостійно: замовлення, відправлені із затримкою понад 3 дні.

```sql
SELECT order_id, order_date, shipped_date
FROM orders
WHERE shipped_date IS NOT NULL
  AND shipped_date > order_date + INTERVAL '3 days'
ORDER BY order_date DESC;
```

**Бізнес-логіка:** Виявляє порушення швидкості обробки. Саме такі замовлення стають причиною скарг.

![Результат запиту 67](screenshots/q67.png)

**Запит 68.** Самостійно: зняті з виробництва товари, залишки яких ще є на складі.

```sql
SELECT product_name, unit_price, units_in_stock
FROM products
WHERE discontinued
  AND units_in_stock > 0
ORDER BY units_in_stock DESC;
```

**Бізнес-логіка:** Це залишки, які вже не поповнюватимуться. Їх доцільно розпродати зі знижкою, поки вони не застаріли.

![Результат запиту 68](screenshots/q68.png)
