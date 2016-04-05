import sys

def long_substr(data):
    substr = ''
    if len(data) > 1 and len(data[0]) > 0:
        for i in range(len(data[0])):
            for j in range(len(data[0])-i+1):
                if j > len(substr) and is_substr(data[0][i:i+j], data):
                    substr = data[0][i:i+j]
    return substr

def is_substr(find, data):
    if len(data) < 1 and len(find) < 1:
        return False
    for i in range(len(data)):
        if find not in data[i]:
            return False
    return True

print (long_substr([sys.argv[1],
    sys.argv[2],
    sys.argv[3]]))
# print (long_substr(['Oh, hello, hhhhh my friend.',
#                    'I prefer Jelly Belly beans. hhhhh',
#                    'When hell freezes ovhhhhher!']))