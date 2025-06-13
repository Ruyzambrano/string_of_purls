from datetime import datetime

import asyncio
import logging
from logging import INFO

from extract_data import get_pattern_info

async def format_pattern(pattern: dict, username: str, password: str):
    pattern_id = pattern.get("id")
    pattern_info = await get_pattern_info(pattern_id, username, password)
    if pattern_info:
        return (
            pattern_id,
            pattern_info.get("currency"),
            pattern_info.get("name"),
            datetime.strptime(pattern_info.get("created_at"), "%Y/%m/%d %H:%M:%S %z"),
            pattern_info.get("favorites_count", 0),
            pattern_info.get("gauge"),
            pattern_info.get("gauge_divisor"),
            pattern_info.get("gauge_pattern"),
            pattern_info.get("price", 0.00),
            pattern_info.get("rating_average", 0.0),
            pattern_info.get("url"),
            pattern_info.get("yardage"),
            pattern_info.get("gauge_description"),
            pattern_info.get("yardage_max"),
            pattern_info.get("pattern_author", {}).get("id"),
            pattern_info.get("notes")
        )


async def process_patterns(pattern_response, username, password):
    coroutines = []
    for pattern in pattern_response:
        if pattern:
            coroutines.append(format_pattern(pattern, username, password))
    patterns = await asyncio.gather(*coroutines)
    return [pattern for pattern in patterns if pattern]


if __name__ == "__main__":
    load_dotenv()
    logging.basicConfig(level=INFO)