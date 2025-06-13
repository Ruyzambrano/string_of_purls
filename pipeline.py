import asyncio
from dotenv import load_dotenv
from os import environ as ENV

import logging
from logging import INFO

from load_data import insert_data
from extract_data import get_pattern_search
from transform_data import process_patterns


async def main(username, password):
    logging.info("Getting all patterns")
    pattern_response = await get_pattern_search(username, password)
    logging.info("Getting more data on patterns")
    return await process_patterns(pattern_response, username, password)


if __name__ == "__main__":
    load_dotenv()
    logging.basicConfig(level=INFO)

    username = ENV.get("USERNAME")
    password = ENV.get("PASSWORD")

    data = asyncio.run(main(username, password))
    insert_data(data)
