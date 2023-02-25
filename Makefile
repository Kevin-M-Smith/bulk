clean:
	rm -rf .ipynb_checkpoints
	rm -rf **/.ipynb_checkpoints
	rm -rf .pytest_cache
	rm -rf build
	rm -rf dist
	rm -rf downloads
	black bulk
	black tests
	isort bulk

pypi: clean
	python setup.py sdist
	python setup.py bdist_wheel --universal
	twine upload dist/*

install:
	python -m pip install --upgrade pip
	python -m pip install -e ".[dev]"
	python -m pip install twine wheel black isort

serve:
	python -m bulk text cluestarred.csv

test-js:
	python scripts/prep-js.py
	npx mocha js/tests.js

test-py:
	pytest

test: test-js test-py

check: clean test clean