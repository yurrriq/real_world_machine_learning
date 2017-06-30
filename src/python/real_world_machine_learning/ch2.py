from numpy import (array, unique)

cat_data = array([
    'male', 'female', 'male', 'male',
    'female', 'male', 'female', 'female'
])

def cat_to_num(data):
    categories = unique(data)
    features = []
    for cat in categories:
        binary = (data == cat)
        features.append(binary.astype("int"))
    return features

cabin_data = array(["C65", "", "E36", "C54", "B57 B59 B63 B66"])

def _cabin_char(cabins):
    try:
        return len(cabins), cabins[0][0]
    except IndexError:
        return 0, "X"

def _cabin_num(cabins):
    try:
        return int(cabins[0][1:])
    except:
        return -1

def cabin_features(data):
    features = []
    for cabin in data:
        cabins = cabin.split(" ")
        n_cabins, cabin_char = _cabin_char(cabins)
        cabin_num = _cabin_num(cabins)
        features.append([cabin_char, cabin_num, n_cabins])
    return features
