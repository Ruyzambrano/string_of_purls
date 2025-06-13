DROP TABLE IF EXISTS pattern, ravelry_user, designer, pattern_category_assignment, category, needle_pattern_assignment, needle, needle_pattern_assignment, photo, photo_pattern_assignment, yarn_weight, yarn, pattern_yarn_assignment, fiber_type, fiber_type_assignment, pattern_attribute, pattern_attribute_assignment;

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

CREATE TABLE category (
    category_id BIGINT PRIMARY KEY,
    category_description VARCHAR,
    category_parent_id BIGINT
);

CREATE TABLE pattern_category_assignment (
    pattern_category_assignment_id BIGINT PRIMARY KEY,
    category_id BIGINT,
    pattern_id BIGINT,
    FOREIGN KEY (category_id) REFERENCES category(category_id),
    FOREIGN KEY (pattern_id) REFERENCES pattern(pattern_id)
);

CREATE TABLE pattern_attribute (
    pattern_attribute_id BIGINT PRIMARY KEY,
    pattern_attribute_description VARCHAR
);

CREATE TABLE pattern_attribute_assignment (
    pattern_attribute_assignment BIGINT PRIMARY KEY,
    pattern_attributes_id BIGINT,
    pattern_id BIGINT,
    FOREIGN KEY (pattern_attributes_id ) REFERENCES pattern_attribute(pattern_attribute_id),
    FOREIGN KEY (pattern_id) REFERENCES pattern(pattern_id)
);

CREATE TABLE needle (
    needle_id INT PRIMARY KEY,
    us_size VARCHAR,
    metric_size FLOAT,
    needle_type VARCHAR
);

CREATE TABLE needle_pattern_assignment (
    needle_pattern_assignment_id BIGINT PRIMARY KEY,
    needle_id INT,
    pattern_id BIGINT,
    FOREIGN KEY (needle_id) REFERENCES needle(needle_id),
    FOREIGN KEY (pattern_id) REFERENCES pattern(pattern_id)
);

CREATE TABLE photo (
    photo_id BIGINT PRIMARY KEY,
    photo_url VARCHAR
);

CREATE TABLE photo_pattern_assignment (
    photo_pattern_assignment_id BIGINT PRIMARY KEY,
    photo_id BIGINT,
    pattern_id BIGINT,
    FOREIGN KEY (photo_id) REFERENCES photo(photo_id),
    FOREIGN KEY (pattern_id) REFERENCES pattern(pattern_id)
);


CREATE TABLE yarn_weight (
    yarn_weight_id BIGINT PRIMARY KEY,
    yarn_weight_name VARCHAR
);

CREATE TABLE "yarn"(
    "yarn_id" BIGINT PRIMARY KEY,
    "discontinued" BOOLEAN,
    "machine_washable" BOOLEAN,
    "yarn_name" VARCHAR,
    "average_rating" FLOAT,
    "wpi" INT,
    "yardage" FLOAT,
    "notes" TEXT,
    "yarn_weight_id" BIGINT,
    "min_needle_size" BIGINT,
    "max_needle_size" BIGINT,
    FOREIGN KEY (yarn_weight_id) REFERENCES yarn_weight(yarn_weight_id)
);

CREATE TABLE pattern_yarn_assignment (
    pattern_yarn_assignment BIGINT PRIMARY KEY,
    pattern_id BIGINT,
    yarn_id BIGINT,
    FOREIGN KEY (pattern_id) REFERENCES pattern(pattern_id),
    FOREIGN KEY (yarn_id) REFERENCES yarn(yarn_id)
);

CREATE TABLE fiber_type (
    fiber_type_id BIGINT PRIMARY KEY,
    fiber_group VARCHAR,
    fiber_name VARCHAR
);

CREATE TABLE fiber_type_assignment (
    fiber_type_assignment_id BIGINT PRIMARY KEY,
    fiber_type_id BIGINT,
    yarn_id BIGINT,
    percentage INT,
    FOREIGN KEY (fiber_type_id) REFERENCES fiber_type(fiber_type_id),
    FOREIGN KEY (yarn_id) REFERENCES yarn(yarn_id)
);