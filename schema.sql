DROP TABLE IF EXISTS pattern, ravelry_user, designer, pattern_category_assignment, pattern_categories;

CREATE TABLE "pattern"(
    "pattern_id" BIGINT PRIMARY KEY,
    "currency" VARCHAR(5),
    "pattern_name" VARCHAR(255),
    "created_at" TIMESTAMP,
    "favorites_count" INTEGER,
    "gauge" FLOAT,
    "gauge_divisor" INT,
    "gauge_pattern" VARCHAR,
    "price" FLOAT,
    "rating_average" FLOAT,
    "url" VARCHAR(255),
    "yardage_min" FLOAT,
    "gauge_description" TEXT,
    "yardage_max" FLOAT,
    "designer_id" BIGINT,
    "notes" TEXT
);

CREATE TABLE ravelry_user (
    user_id BIGINT PRIMARY KEY,
    username VARCHAR,
    user_name VARCHAR,
    photo_url VARCHAR
);

CREATE TABLE designer (
    designer_id bigint PRIMARY KEY,
    crochet_pattern_count VARCHAR,
    knitting_pattern_count VARCHAR,
    designer_name VARCHAR,
    user_id BIGINT,
    FOREIGN KEY (user_id) REFERENCES ravelry_user(user_id)
);

CREATE TABLE pattern_categories (
    pattern_category_id BIGINT PRIMARY KEY,
    pattern_category_description VARCHAR,
    pattern_category_parent_id BIGINT
);

CREATE TABLE pattern_category_assignment (
    pattern_category_assignment_id BIGINT PRIMARY KEY,
    pattern_category_id BIGINT,
    pattern_id BIGINT,
    FOREIGN KEY (pattern_category_id) REFERENCES pattern_categories(pattern_category_id),
    FOREIGN KEY (pattern_id) REFERENCES pattern(pattern_id)
);