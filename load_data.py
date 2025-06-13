"""Loads data into the database"""

from psycopg2 import connect
from psycopg2.extras import RealDictCursor

import logging
from logging import INFO


def get_connection():
    return connect(
        dbname="string_of_purls",
        user="ruyzambrano",
        cursor_factory=RealDictCursor
    )


def insert_data(patterns: list[dict]): 
    logging.info("Getting connection")
    conn = get_connection()
    logging.info("Getting cursor")
    with conn.cursor() as cur:
        query = """
        INSERT INTO pattern (
            pattern_id, currency, pattern_name, created_at, favorites_count,
            gauge, gauge_divisor, gauge_pattern, price, rating_average, url,
            yardage_min, gauge_description, yardage_max, designer_id, notes
        ) VALUES (%s, %s, %s, %s,
                  %s, %s, %s, %s,
                  %s, %s, %s, %s,
                  %s, %s, %s, %s)
        ON CONFLICT DO NOTHING;
        """
        logging.info(f"Rows to insert: {len(patterns)}")
        try:
            cur.executemany(query, patterns)
            conn.commit()
            logging.info("Data inserted successfully")
        except Exception as e:
            logging.error(f"An error occurred: {e}")
        finally:
            conn.close()


if __name__ == "__main__":
    logging.basicConfig(level=INFO)