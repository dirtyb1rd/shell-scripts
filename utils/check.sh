#!/bin/bash
# template: python quality checks

set -e

echo "linting..."
ruff check .

echo "type checking..."
mypy .

echo "testing..."
pytest

echo "all good"
