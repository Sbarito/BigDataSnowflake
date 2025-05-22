CREATE TABLE country (
    id SERIAL PRIMARY KEY,
    name_country VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE city (
    id SERIAL PRIMARY KEY,
    name_city VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE state (
    id SERIAL PRIMARY KEY,
    name_state VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE month (
    id SERIAL PRIMARY KEY,
    name_month VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE day (
    id SERIAL PRIMARY KEY,
    name_day VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE product_categorys (
    id SERIAL PRIMARY KEY,
    name_product_categorys VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE colors (
    id SERIAL PRIMARY KEY,
    name_colors VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE brands (
    id SERIAL PRIMARY KEY,
    name_brands VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE materials (
    id SERIAL PRIMARY KEY,
    name_materials VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE sizes (
    id SERIAL PRIMARY KEY,
    name_sizes VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE pet_types (
    id SERIAL PRIMARY KEY,
    name_pet_types VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE breeds (
    id SERIAL PRIMARY KEY,
    name_breeds VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE pet_categorys (
    id SERIAL PRIMARY KEY,
    name_pet_categorys VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE time (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL UNIQUE,
    year INT,
    quarter INT,
    month_id INT,
    day_id INT,
    FOREIGN KEY (month_id) REFERENCES month (id) ON DELETE SET NULL,
    FOREIGN KEY (day_id) REFERENCES day (id) ON DELETE SET NULL
);

CREATE TABLE supplier (
    id SERIAL PRIMARY KEY,
    name_supplier VARCHAR(50) NOT NULL,
    contact VARCHAR(50),
    email VARCHAR(50) NOT NULL UNIQUE,
    phone VARCHAR(20),
    address VARCHAR(50),
    city_id INT,
    country_id INT,
    FOREIGN KEY (city_id) REFERENCES city (id) ON DELETE SET NULL,
    FOREIGN KEY (country_id) REFERENCES country (id) ON DELETE SET NULL
);

CREATE TABLE customer (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    email VARCHAR(50),
    country_id INT,
    postal_code VARCHAR(20),
    FOREIGN KEY (country_id) REFERENCES country (id) ON DELETE SET NULL
);

CREATE TABLE seller (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    country_id INT,
    postal_code VARCHAR(20),
    FOREIGN KEY (country_id) REFERENCES country (id) ON DELETE SET NULL
);

CREATE TABLE store (
    id SERIAL PRIMARY KEY,
    name_store VARCHAR(50),
    location VARCHAR(50),
    city_id INT,
    state_id INT,
    country_id INT,
    phone VARCHAR(20),
    email VARCHAR(50),
    FOREIGN KEY (city_id) REFERENCES city (id) ON DELETE SET NULL,
    FOREIGN KEY (state_id) REFERENCES state (id) ON DELETE SET NULL,
    FOREIGN KEY (country_id) REFERENCES country (id) ON DELETE SET NULL
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name_products VARCHAR(50) NOT NULL,
    category_id INT,
    price DECIMAL(10, 2),
    quantity INT,
    weight DECIMAL(10, 2),
    color_id INT,
    size_id INT,
    brand_id INT,
    material_id INT,
    description TEXT,
    rating DECIMAL(2, 1),
    reviews INT,
    release_date_id INT,
    expiry_date_id INT,
    FOREIGN KEY (category_id) REFERENCES product_categorys (id) ON DELETE SET NULL,
    FOREIGN KEY (size_id) REFERENCES sizes (id) ON DELETE SET NULL,
    FOREIGN KEY (color_id) REFERENCES colors (id) ON DELETE SET NULL,
    FOREIGN KEY (brand_id) REFERENCES brands (id) ON DELETE SET NULL,
    FOREIGN KEY (material_id) REFERENCES materials (id) ON DELETE SET NULL,
    FOREIGN KEY (release_date_id) REFERENCES time (id) ON DELETE SET NULL,
    FOREIGN KEY (expiry_date_id) REFERENCES time (id) ON DELETE SET NULL
);

CREATE TABLE pets (
    id SERIAL PRIMARY KEY,
    name_pets VARCHAR(50),
    customer_id INT,
    type_id INT,
    breed_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer (id) ON DELETE CASCADE,
    FOREIGN KEY (type_id) REFERENCES pet_types (id) ON DELETE SET NULL,
    FOREIGN KEY (breed_id) REFERENCES breeds (id) ON DELETE SET NULL
);

CREATE TABLE sales_table (
    id SERIAL PRIMARY KEY,
    date_id INT,
    customer_id INT,
    seller_id INT,
    product_id INT,
    quantity INT,
    total_price DECIMAL(10, 2),
    FOREIGN KEY (date_id) REFERENCES time (id) ON DELETE SET NULL,
    FOREIGN KEY (customer_id) REFERENCES customer (id) ON DELETE SET NULL,
    FOREIGN KEY (seller_id) REFERENCES seller (id) ON DELETE SET NULL,
    FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE SET NULL
);