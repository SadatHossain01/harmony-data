import pandas as pd

pd.set_option('display.max_rows', None)
pd.set_option('display.max_columns', None)
pd.set_option('display.width', None)
# pd.set_option('display.max_colwidth', -1)
pd.set_option('display.max_columns', None)

df = pd.read_excel('CSE19 DB.xlsx')
def get_username(str):
    ret = ""
    for a in str:
        ret += a.strip()
    # print(str, ret)
    return ret

def get_middle_name(str):
    ll = str.split(' ')
    # print(ll)
    n = len(ll)
    # print(n)
    ret = ""
    for i in range(1, n - 1):
        ret += ll[i]
        if i < n - 1:
            ret += " "
    # print(ret)
    return ret.strip()

with open('out.txt', 'w') as file:
    for (index_label, row_series) in df.iterrows():
        if index_label == 0:
            continue
        roll = row_series.values[4]
        id = row_series.values[6]
        name = row_series.values[7]
        email = row_series.values[-1]
        username = get_username(name)
        midname = get_middle_name(name)
        print(roll, id, name, email, username, midname)
        file.write("INSERT INTO \"User\"(user_name, password, fname, mname, lname) VALUES('" + username + "', '" + "1234'" + ", '" + name.split()[0] + "', '" + midname + "', '" + name.split()[-1] + "');\n")


