import yaml


def validate_yaml(data) -> bool:
    try:
        yaml.load(stream=data, Loader=yaml.SafeLoader)
        return True
    except yaml.error.YAMLError:
        return False
    except:
        return False
