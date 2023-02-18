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