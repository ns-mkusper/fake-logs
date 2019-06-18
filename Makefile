SOURCES = $(shell find . -name "*.py")

clean:
	rm -f infra/lambda_fake_logs.zip
	rm -rf package

install:
	pip3.7 install -r requirements.txt
	git submodule update --init

lint:
	flake8 fake_logs/ # tests/

component:
	pytest -sv tests

coverage:
	coverage run --source=cfripper --branch -m pytest tests/ --junitxml=build/test.xml -v
	coverage report
	coverage xml -i -o build/coverage.xml

test: lint component

freeze:
	pip3.7-compile --output-file requirements.txt setup.py

lambda_fake_logs.zip: $(SOURCES) Makefile requirements.txt
	if [ -f infra/lambda_fake_logs.zip ]; then rm infra/lambda_fake_logs.zip; fi
	if [ -d "./package" ]; then rm -rf package/; fi
	pip3.7 install -t package -r requirements.txt
	mkdir -p package/fake_logs
	cp -r fake_logs package/
	cd ./package && zip -rq ../infra/lambda_fake_logs.zip .
	cd ../
	zip -u  infra/lambda_fake_logs.zip  main.py
	rm -rf ./package

.PHONY: install install-dev lint component coverage test freeze
