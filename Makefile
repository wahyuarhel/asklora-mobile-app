.PHONY: all run_dev_web run_dev_mobile run_test clean upgrade lint format build_dev_mobile help

all: lint format run_dev_mobile

pr: format lint run_test

help: ## This help dialog.
	@IFS=$$'\n' ; \
	help_lines=(`fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//'`); \
	for help_line in $${help_lines[@]}; do \
		IFS=$$'#' ; \
		help_split=($$help_line) ; \
		help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		printf "%-30s %s\n" $$help_command $$help_info ; \
	done

run_test: ## Runs unit tests
	@echo "╠ Running the tests"
	@flutter test --coverage || (echo "Error while running tests"; exit 1)

clean: ## Cleans the environment
	@echo "╠ Cleaning the project..."
	@rm -rf pubspec.lock
	@flutter clean

get: ## Get all dependencies
	@echo "╠Getting all dependencies..."
	@flutter pub get

format: ## Formats the code
	@echo "╠ Formatting the code"
	@dart format --set-exit-if-changed .

lint: ## Lints the code
	@echo "╠ Verifying code..."
	@dart analyze . || (echo "▓▓ Lint error ▓▓"; exit 1)

upgrade: clean ## Upgrades dependencies
	@echo "╠ Upgrading dependencies..."
	@flutter pub upgrade

commit: format lint run_test
	@echo "╠ Committing..."
	git add .
	git commit

run_dev_mobile: ## Runs the mobile application in dev
	@echo "╠ Running the app"
	@flutter run --flavor dev --dart-define=ENVIRONMENT=dev

run_staging_mobile: ## Runs the mobile application in staging
	@echo "╠ Running the app"
	@flutter run --flavor staging --dart-define=ENVIRONMENT=staging

run_production_mobile: ## Runs the mobile application in production
	@echo "╠ Running the app"
	@flutter run --flavor production --dart-define=ENVIRONMENT=production

build_runner:
	@echo "╠ Generating the code"
	@dart run build_runner build --delete-conflicting-outputs

#run_dev_mobile: ## Runs the mobile application in dev
#	@echo "╠ Running the app"
#	@flutter run --flavor dev

build_dev: clean run_test
	@echo "╠  Building the dev apk"
	@flutter build apk --flavor dev --dart-define=ENVIRONMENT=dev

build_and_upload_dev: clean get ## Create and upload the android build on firebase
	@echo "╠  Building the app"
	cd android && fastlane android create_dev

build_prod: clean run_test
	@echo "╠  Building the production apk"
	@flutter build apk --flavor dev --dart-define=ENVIRONMENT=production

build_stag: clean run_test
	@echo "╠  Building the staging apk"
	@flutter build apk --flavor staging --dart-define=ENVIRONMENT=staging