from typing import Any, Dict, Optional
from pydantic import BaseModel


class QueryRequest(BaseModel):
    """Model for dynamic report queries.

    - `filters`: mapping of allowed filter names to values.
    - `limit` / `offset`: pagination controls.
    """

    filters: Optional[Dict[str, Any]] = None
    limit: int = 100
    offset: int = 0
