import re
content = open('pov.test.tcl', 'r', encoding='utf-8', errors='ignore').read()
print(set(re.findall(r'-result \"(.*?)\"', content)))
