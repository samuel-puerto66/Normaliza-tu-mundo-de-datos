-- freds_furniture.sql
DROP DATABASE IF EXISTS freds_furniture;
CREATE DATABASE freds_furniture CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE freds_furniture;

-- TABLA: customers
CREATE TABLE customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(80) NOT NULL,
  last_name VARCHAR(80) NOT NULL,
  email VARCHAR(150),
  phone VARCHAR(30),
  street VARCHAR(200),
  city VARCHAR(100),
  country VARCHAR(100)
) ENGINE=InnoDB;

-- TABLA: categories
CREATE TABLE categories (
  category_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

-- TABLA: products
CREATE TABLE products (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  sku VARCHAR(50) UNIQUE,
  name VARCHAR(200) NOT NULL,
  description TEXT,
  category_id INT,
  unit_price DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (category_id) REFERENCES categories(category_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- TABLA: stores
CREATE TABLE stores (
  store_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  address VARCHAR(250),
  city VARCHAR(100)
) ENGINE=InnoDB;

-- TABLA: employees
CREATE TABLE employees (
  employee_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(80) NOT NULL,
  last_name VARCHAR(80) NOT NULL,
  store_id INT,
  FOREIGN KEY (store_id) REFERENCES stores(store_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- TABLA: sales
CREATE TABLE sales (
  sale_id INT AUTO_INCREMENT PRIMARY KEY,
  sale_date DATETIME NOT NULL,
  customer_id INT,
  employee_id INT,
  store_id INT,
  subtotal DECIMAL(12,2) DEFAULT 0.00,
  tax DECIMAL(12,2) DEFAULT 0.00,
  total DECIMAL(12,2) DEFAULT 0.00,
  payment_method VARCHAR(50),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  FOREIGN KEY (store_id) REFERENCES stores(store_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- TABLA: sale_items
CREATE TABLE sale_items (
  sale_item_id INT AUTO_INCREMENT PRIMARY KEY,
  sale_id INT NOT NULL,
  product_id INT NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  quantity INT NOT NULL,
  line_total DECIMAL(12,2) NOT NULL,
  FOREIGN KEY (sale_id) REFERENCES sales(sale_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products(product_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- TABLA: payments
CREATE TABLE payments (
  payment_id INT AUTO_INCREMENT PRIMARY KEY,
  sale_id INT NOT NULL,
  amount DECIMAL(12,2) NOT NULL,
  payment_date DATETIME NOT NULL,
  method VARCHAR(50),
  FOREIGN KEY (sale_id) REFERENCES sales(sale_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Datos iniciales
INSERT INTO customers (first_name, last_name, email, phone, street, city, country)
VALUES
('Ana', 'Gomez', 'ana.gomez@mail.com', '3001112222', 'Calle 1 #10-20', 'Bogotá', 'Colombia'),
('Carlos', 'Perez', 'carlos.p@mail.com', '3003334444', 'Carrera 5 #20-30', 'Medellín', 'Colombia');

INSERT INTO categories (name) VALUES
('Sillas'),
('Mesas'),
('Sofás');

INSERT INTO products (sku, name, description, category_id, unit_price) VALUES
('CHAIR-001', 'Silla de madera', 'Silla en madera maciza', 1, 49.90),
('TABLE-001', 'Mesa comedor 4 pax', 'Mesa de comedor metálica y madera', 2, 199.00),
('SOFA-001', 'Sofá 3 puestos', 'Sofá tapizado 3 plazas', 3, 499.00);

INSERT INTO stores (name, address, city) VALUES
('Tienda Centro', 'Av Central 100', 'Bogotá'),
('Tienda Norte', 'Av Norte 55', 'Medellín');

INSERT INTO employees (first_name, last_name, store_id) VALUES
('Luis', 'Martinez', 1),
('María', 'Lopez', 2);

INSERT INTO sales (sale_date, customer_id, employee_id, store_id, subtotal, tax, total, payment_method)
VALUES ('2025-10-29 10:00:00', 1, 1, 1, 49.90, 8.98, 58.88, 'Tarjeta');

INSERT INTO sale_items (sale_id, product_id, unit_price, quantity, line_total)
VALUES (1, 1, 49.90, 1, 49.90);

INSERT INTO payments (sale_id, amount, payment_date, method)
VALUES (1, 58.88, '2025-10-29 10:02:00', 'Tarjeta');

INSERT INTO sales (sale_date, customer_id, employee_id, store_id, subtotal, tax, total, payment_method)
VALUES ('2025-10-30 15:30:00', 2, 2, 2, 698.00, 125.64, 823.64, 'Efectivo');

INSERT INTO sale_items (sale_id, product_id, unit_price, quantity, line_total)
VALUES (2, 2, 199.00, 1, 199.00),
       (2, 3, 499.00, 1, 499.00);

INSERT INTO payments (sale_id, amount, payment_date, method)
VALUES (2, 823.64, '2025-10-30 15:35:00', 'Efectivo');

ALTER TABLE sale_items ADD INDEX (sale_id);
ALTER TABLE sale_items ADD INDEX (product_id);
ALTER TABLE products ADD INDEX (category_id);
