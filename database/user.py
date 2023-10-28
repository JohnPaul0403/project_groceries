import random
import string
import json
import products

class User:
    def __init__(self, name, email, password, username, products) -> None:
        self._name = name
        self._email = email
        self._password = password
        self._username = username
        self._products = products
        self._token = None

    @property
    def name(self):
        return self._name

    @name.setter
    def name(self, value):
        self._name = value

    @property
    def email(self):
        return self._email

    @email.setter
    def email(self, value):
        self._email = value

    @property
    def password(self):
        return self._password

    @password.setter
    def password(self, value):
        self._password = value

    @property
    def products(self):
        return self._products

    @products.setter
    def products(self, value):
        self._products = value

    @property
    def username(self):
        return self._username

    @username.setter
    def username(self, value):
        self._username = value

    @property
    def token(self):
        return self._token

    @token.setter
    def token(self, value):
        self._token = value

    def get_tokken(self):
        len = 14
        letters = []
        for i in range (1, len + 1):
            if i == random.randint(1, len) :
                letters.append(str(random.randint(0, 9)))
                continue
            
            letters.append(random.choice(string.ascii_letters))

        self.token = "".join(letters)
        return {"tokken" : "".join(letters)}
    
    def tojson(self) :
        return {
            "name" : self.name, 
            "email" : self.email, 
            "password" : self.password, 
            "username" : self.username,
            "tokken" : self.token,
            "items" : list(map(lambda x: x.to_json(), self.products))
        }
    
    def update_tokken(self, path) :
        with open(path, 'r') as archivo:
            dta = json.load(archivo)
        
        for _user in dta["users"]:
            if self.username == _user["username"]:
                _user["tokken"] = self.token
                print(_user["tokken"])

        with open(path, 'w') as archivo:
            json.dump({'users' : dta["users"]}, archivo, cls=products.Product_Enconder, indent=4)

class User_Enconder(json.JSONEncoder):
    def default(self, obj: User):
        if isinstance(obj, User):
            return {"name" : obj.name, "email" : obj.email, "password" : obj.password, "username" : obj.username}

        return json.JSONEncoder.default(self, obj)

def User_decoder(dicc, products):
    return User(dicc["name"], dicc["email"], dicc['password'], dicc["username"], products)
    