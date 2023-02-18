# ValidationApp
App validates yaml.

# Requirements

- python3

# Initializing the project

Run the following command

```
python3 -m pip install -r requirements.txt
```

# How to run

### Unit tests

Run the unit test for the validation method by running the following command

```
python3 tests/utils_tests.py
```

*tests/correct_yaml_example* was generated with the following command

```
kubectl create deployment validationapp --image=none --dry-run=client -o yaml > tests/correct_yaml_example
```

### Integration tests

These are tests that use the same validation files used in the unit tests but run against a running local server. Therefore start the server before running these tests with the following script

```
sh scripts/server/start_server.sh
```

Run the following scripts with valid and invalid files and check the server responses
```
sh scripts/server/validate_correct_yaml.sh
sh scripts/server/validate_incorrect_yaml.sh
```