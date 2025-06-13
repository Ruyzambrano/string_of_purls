"""Extracts data from Ravelry"""

import aiohttp
import logging

import logging
from logging import INFO

BASE_URL = "https://api.ravelry.com"

async def make_get_request(url, username, password):
    async with aiohttp.ClientSession() as session:
        async with session.get(url, auth=aiohttp.BasicAuth(username, password)) as response:
            if response.status == 200:
                return await response.json()
            else:
                return {
                    "Error": True,
                    "Status Code": response.status,
                    "Message": await response.text()
                }


async def get_yarn_info(yarn_id: str, username: str, password: str):
    url = BASE_URL + f"/yarns/{yarn_id}.json"
    return await make_get_request(url, username, password)


async def get_pattern_info(pattern_id: str, username: str, password: str):
    url = BASE_URL + f"/patterns/{pattern_id}.json"
    logging.info(f"Getting pattern {pattern_id}")
    response = await make_get_request(url, username, password)
    return response.get("pattern")


async def get_pattern_search(username: str, password: str, query: str=None) -> list:
    url = BASE_URL + "/patterns/search.json"
    if query:
        url += f"?query={query}"
    response = await make_get_request(url, username, password)
    return response.get("patterns", [])

if __name__ == "__main__":
    logging.basicConfig(level=INFO)