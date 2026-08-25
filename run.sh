#!/bin/sh

set -e

export DATABASE_URL="postgresql+asyncpg://${POSTGRES_CONNECTION_STRING#postgres://}"
export KAFKA_BOOTSTRAP_SERVERS="$KAFKA_BROKERS"

uv run alembic upgrade head

uv run python -m bin.outbox &
exec uv run python -m bin.api