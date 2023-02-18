import sys
sys.path.insert(0, 'src/')

from utils import *


def test_valid_yaml():
    with open("tests/correct_yaml_example", 'r') as stream:
        result = validate_yaml(stream)
        assert result == True

def test_invalid_yaml():
    with open("tests/incorrect_yaml_example", 'r') as stream:
        result = validate_yaml(stream)
        assert result == False

test_valid_yaml()
test_invalid_yaml()