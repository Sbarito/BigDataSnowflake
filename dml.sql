INSERT INTO
    country (name_country)
SELECT DISTINCT
    country
FROM (
        SELECT customer_country AS country
        FROM mock_data
        UNION
        SELECT store_country AS country
        FROM mock_data
        UNION
        SELECT supplier_country AS country
        FROM mock_data
    ) AS combined_countries
WHERE
    country IS NOT NULL
    AND LENGTH(country) > 0 ON CONFLICT (name_country) DO NOTHING;

INSERT INTO
    city (name_city)
SELECT DISTINCT
    city
FROM (
        SELECT store_city AS city
        FROM mock_data
        UNION
        SELECT supplier_city AS city
        FROM mock_data
    ) AS combined_cities
WHERE
    city IS NOT NULL
    AND LENGTH(city) > 0 ON CONFLICT (name_city) DO NOTHING;

INSERT INTO
    state (name_state)
SELECT DISTINCT
    store_state
FROM mock_data
WHERE
    store_state IS NOT NULL
    AND LENGTH(store_state) > 0 ON CONFLICT (name_state) DO NOTHING;

INSERT INTO
    pet_types (name_pet_types)
SELECT DISTINCT
    customer_pet_type
FROM mock_data
WHERE
    customer_pet_type IS NOT NULL
    AND LENGTH(customer_pet_type) > 0 ON CONFLICT (name_pet_types) DO NOTHING;

INSERT INTO
    breeds (name_breeds)
SELECT DISTINCT
    customer_pet_breed
FROM mock_data
WHERE
    customer_pet_breed IS NOT NULL
    AND LENGTH(customer_pet_breed) > 0 ON CONFLICT (name_breeds) DO NOTHING;

INSERT INTO
    pet_categorys (name_pet_categorys)
SELECT DISTINCT
    pet_category
FROM mock_data
WHERE
    pet_category IS NOT NULL
    AND LENGTH(pet_category) > 0 ON CONFLICT (name_pet_categorys) DO NOTHING;

INSERT INTO
    product_categorys (name_product_categorys)
SELECT DISTINCT
    product_category
FROM mock_data
WHERE
    product_category IS NOT NULL
    AND LENGTH(product_category) > 0 ON CONFLICT (name_product_categorys) DO NOTHING;

INSERT INTO
    colors (name_colors)
SELECT DISTINCT
    product_color
FROM mock_data
WHERE
    product_color IS NOT NULL
    AND LENGTH(product_color) > 0 ON CONFLICT (name_colors) DO NOTHING;

INSERT INTO
    brands (name_brands)
SELECT DISTINCT
    product_brand
FROM mock_data
WHERE
    product_brand IS NOT NULL
    AND LENGTH(product_brand) > 0 ON CONFLICT (name_brands) DO NOTHING;

INSERT INTO
    materials (name_materials)
SELECT DISTINCT
    product_material
FROM mock_data
WHERE
    product_material IS NOT NULL
    AND LENGTH(product_material) > 0 ON CONFLICT (name_materials) DO NOTHING;

INSERT INTO
    month (name_month)
VALUES ('January'),
    ('February'),
    ('March'),
    ('April'),
    ('May'),
    ('June'),
    ('July'),
    ('August'),
    ('September'),
    ('October'),
    ('November'),
    ('December');

INSERT INTO
    day (name_day)
VALUES ('Monday'),
    ('Tuesday'),
    ('Wednesday'),
    ('Thursday'),
    ('Friday'),
    ('Saturday'),
    ('Sunday');

INSERT INTO
    customer (
        first_name,
        last_name,
        age,
        email,
        country_id,
        postal_code
    )
SELECT DISTINCT
    customer_first_name,
    customer_last_name,
    customer_age,
    customer_email,
    (
        SELECT id
        FROM country
        WHERE
            name_country = customer_country
    ),
    customer_postal_code
FROM mock_data;

INSERT INTO pets (
    name_pets,
    customer_id,
    type_id,
    breed_id
)
SELECT DISTINCT
    customer_pet_name,
    (
        SELECT id
        FROM customer
        WHERE
            email = mock_data.customer_email
            AND first_name = mock_data.customer_first_name
            AND last_name = mock_data.customer_last_name
            AND age = mock_data.customer_age
        LIMIT 1 
    ),
    (
        SELECT id
        FROM pet_types
        WHERE
            name_pet_types = mock_data.customer_pet_type  
        LIMIT 1
    ),
    (
        SELECT id
        FROM breeds
        WHERE
            name_breeds = mock_data.customer_pet_breed  
        LIMIT 1
    )
FROM mock_data
WHERE (
    SELECT id FROM customer
    WHERE email = mock_data.customer_email
    AND first_name = mock_data.customer_first_name
    AND last_name = mock_data.customer_last_name
    AND age = mock_data.customer_age
) IS NOT NULL;

INSERT INTO seller (
    first_name,
    last_name,
    email,
    country_id,
    postal_code
)
SELECT DISTINCT
    seller_first_name,
    seller_last_name,
    seller_email,
    (
        SELECT id
        FROM country
        WHERE
            name_country = mock_data.seller_country
    ),
    seller_postal_code
FROM mock_data
WHERE (
    SELECT id
    FROM country
    WHERE name_country = mock_data.seller_country
) IS NOT NULL;

INSERT INTO
    time (
        date,
        year,
        quarter,
        month_id,
        day_id
    )
SELECT DISTINCT
    TO_DATE (sale_date, 'MM/DD/YYYY') AS date,
    EXTRACT(
        YEAR
        FROM TO_DATE (sale_date, 'MM/DD/YYYY')
    ) AS year,
    EXTRACT(
        QUARTER
        FROM TO_DATE (sale_date, 'MM/DD/YYYY')
    ) AS quarter,
    EXTRACT(
        MONTH
        FROM TO_DATE (sale_date, 'MM/DD/YYYY')
    ) AS month_id,
    EXTRACT(
        DOW
        FROM TO_DATE (sale_date, 'MM/DD/YYYY')
    ) + 1 AS day_id
FROM mock_data
WHERE
    sale_date IS NOT NULL
UNION
SELECT DISTINCT
    TO_DATE (
        product_release_date,
        'MM/DD/YYYY'
    ) AS date,
    EXTRACT(
        YEAR
        FROM TO_DATE (
                product_release_date, 'MM/DD/YYYY'
            )
    ) AS year,
    EXTRACT(
        QUARTER
        FROM TO_DATE (
                product_release_date, 'MM/DD/YYYY'
            )
    ) AS quarter,
    EXTRACT(
        MONTH
        FROM TO_DATE (
                product_release_date, 'MM/DD/YYYY'
            )
    ) AS month_id,
    EXTRACT(
        DOW
        FROM TO_DATE (
                product_release_date, 'MM/DD/YYYY'
            )
    ) + 1 AS day_id
FROM mock_data
WHERE
    product_release_date IS NOT NULL
UNION
SELECT DISTINCT
    TO_DATE (
        product_expiry_date,
        'MM/DD/YYYY'
    ) AS date,
    EXTRACT(
        YEAR
        FROM TO_DATE (
                product_expiry_date, 'MM/DD/YYYY'
            )
    ) AS year,
    EXTRACT(
        QUARTER
        FROM TO_DATE (
                product_expiry_date, 'MM/DD/YYYY'
            )
    ) AS quarter,
    EXTRACT(
        MONTH
        FROM TO_DATE (
                product_expiry_date, 'MM/DD/YYYY'
            )
    ) AS month_id,
    EXTRACT(
        DOW
        FROM TO_DATE (
                product_expiry_date, 'MM/DD/YYYY'
            )
    ) + 1 AS day_id
FROM mock_data
WHERE
    product_expiry_date IS NOT NULL ON CONFLICT (date) DO NOTHING;

INSERT INTO products (
    name_products,
    category_id,
    price,
    quantity,
    weight,
    color_id,
    size_id,  
    brand_id,
    material_id,
    description,
    rating,
    reviews,
    release_date_id,
    expiry_date_id
)
SELECT DISTINCT
    product_name,
    (
        SELECT id
        FROM product_categorys 
        WHERE name_product_categorys = product_category
    ),
    product_price,
    product_quantity,
    product_weight,
    (
        SELECT id
        FROM colors  
        WHERE name_colors = product_color
    ),
    (
        SELECT id
        FROM sizes 
        WHERE name_sizes = product_size
    ),
    (
        SELECT id
        FROM brands  
        WHERE name_brands = product_brand
    ),
    (
        SELECT id
        FROM materials  
        WHERE name_materials = product_material
    ),
    product_description,
    product_rating,
    product_reviews,
    (
        SELECT id
        FROM time
        WHERE date = TO_DATE(product_release_date, 'MM/DD/YYYY')
    ),
    (
        SELECT id
        FROM time
        WHERE date = TO_DATE(product_expiry_date, 'MM/DD/YYYY')
    )
FROM mock_data;

INSERT INTO sales_table (
    date_id,
    customer_id,
    seller_id,
    product_id,
    quantity,
    total_price
)
SELECT DISTINCT (
    SELECT id
    FROM time
    WHERE date = TO_DATE(sale_date, 'MM/DD/YYYY')
),
(
    SELECT id
    FROM customer
    WHERE email = customer_email
        AND first_name = customer_first_name
        AND last_name = customer_last_name
        AND age = customer_age
    LIMIT 1
), (
    SELECT id
    FROM seller
    WHERE email = seller_email
        AND first_name = seller_first_name
        AND last_name = seller_last_name
),
(
    SELECT id
    FROM products
    WHERE name_products = product_name
        AND price = ROUND(product_price::numeric, 2)
        AND quantity = product_quantity
        AND weight = ROUND(product_weight::numeric, 2)
        AND size_id = (
            SELECT id
            FROM sizes
            WHERE name_sizes = product_size
        )
        AND color_id = (
            SELECT id
            FROM colors
            WHERE name_colors = product_color
        )
        AND brand_id = (
            SELECT id
            FROM brands
            WHERE name_brands = product_brand
        )
        AND material_id = (
            SELECT id
            FROM materials
            WHERE name_materials = product_material
        )
        AND description = product_description
        AND rating = ROUND(product_rating::numeric, 1)
        AND reviews = product_reviews
        AND release_date_id = (
            SELECT id
            FROM time
            WHERE date = TO_DATE(product_release_date, 'MM/DD/YYYY')
        )
        AND expiry_date_id = (
            SELECT id
            FROM time
            WHERE date = TO_DATE(product_expiry_date, 'MM/DD/YYYY')
        )
),
sale_quantity,
sale_total_price
FROM mock_data;

INSERT INTO
    store (
        name,
        location,
        city_id,
        state_id,
        country_id,
        phone,
        email
    )
SELECT DISTINCT
    store_name,
    store_location,
    (
        SELECT id
        FROM city
        WHERE
            name = store_city
    ),
    (
        SELECT id
        FROM state
        WHERE
            name = store_state
    ),
    (
        SELECT id
        FROM country
        WHERE
            name = store_country
    ),
    store_phone,
    store_email
FROM mock_data;

INSERT INTO
    store (
        name_store,
        location,
        city_id,
        state_id,
        country_id,
        phone,
        email
    )
SELECT DISTINCT
    store_name,
    store_location,
    (
        SELECT id
        FROM city
        WHERE
            name_city = store_city
    ),
    (
        SELECT id
        FROM state
        WHERE
            name_state = store_state
    ),
    (
        SELECT id
        FROM country
        WHERE
            name_country = store_country
    ),
    store_phone,
    store_email
FROM mock_data;

INSERT INTO
    supplier (
        name_supplier,
        contact,
        email,
        phone,
        address,
        city_id,
        country_id
    )
SELECT DISTINCT
    supplier_name,
    supplier_contact,
    supplier_email,
    supplier_phone,
    supplier_address,
    (
        SELECT id
        FROM city
        WHERE
            name_city = supplier_city
    ),
    (
        SELECT id
        FROM country
        WHERE
            name_country = supplier_country
    )
FROM mock_data;

INSERT INTO sizes (name_sizes)
SELECT DISTINCT product_size
FROM mock_data
WHERE product_size IS NOT NULL
  AND product_size <> ''
  AND NOT EXISTS (
      SELECT 1 
      FROM sizes 
      WHERE name_sizes = mock_data.product_size
  );