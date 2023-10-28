#Class Groceries
#This class manage all the groceries while it stores it in a json file
#This will be the first step for the Data Base
import products
import json
import os
import pathlib
from user import User, User_decoder, User_Enconder

class Groceries:
    def __init__(self) -> None:
        self._users_json = None
        self._users = []
        self.get_users("libros.json")

    # def __del__(self) -> None :
    #     self.store_products("libros.json")

    @property
    def users(self):
        return self._users
    
    @users.setter
    def users(self, users):
        self._users = users

    @property
    def users_json(self):
        return self._users_json
    
    @users_json.setter
    def users_json(self, dicc):
        self._users_json = dicc

    def get_users(self, path) :
        path_obj = pathlib.Path(path)  # Convert path to a Path object
        if path_obj.exists():
            with open(path_obj, 'r') as archivo:
                dta = json.load(archivo)
            
        self.users_json = dict(dta)
        
        for user in dta["users"]:
            products_user = self.get_products(user["items"])
            self.users.append(User_decoder(user, products_user))

    def get_user(self, username, password) :

        self.users = []
        self.users_json = None
        self.get_users("libros.json")

        for user in self.users:
            if user.username == username and user.password == password:
                #user.products = self.get_products(user['items'])
                user.get_tokken()
                user.update_tokken("libros.json")
                return user.tojson()
            
        return False
            
    def get_user_data(self, tokken) :
        for user in self.users:
            if user.token == tokken:
                return user.tojson()
            
        return False

    def get_products(self, dta):
        products_user = []
        for product in dta:
            products_user.append(products.Product_decoder(product))

        return products_user

    
    def store_products(self, username, path):
        i = 0
        for user in self.users_json["users"]:
            if user["username"] == username:
                user["items"].append(self.users[i].products[-1].to_json())
                break
            i += 1

        with open(path, 'w') as archivo:
            json.dump({'users' : self.users_json["users"]}, archivo, cls=products.Product_Enconder, indent=4)

    def add_products(self, username, new_grocery):
        for user in self.users:
            if user.username == username:
                user.products.append(products.Products(new_grocery["name"], new_grocery["price"], new_grocery["amount"]))
                print("Producto agregado! ")
                return {
                    "code" : 00,
                    "message": "Grocery added successfully"
                }
        
        return {
            "code" : 12,
            "message" : "There was a problem while trying to add the product"
        }


    def see_products(self, username):
        items = []
        for user in self.users:
            if user.username == username:
                if user.products == None or len(user.products) == 0:
                    return {"products" : []}
                else:
                    for product in user.products:
                        print(f'{product}')
                        print("-" * 20)
                        items.append(product.to_json())
                    
                    total_amount = self.get_average(user.products)
                    items.append({"total" : total_amount})
                    
                    return {"products" : items}
                
        return {
            "code" : 13,
            "message" : "There was a problem"
        }

    def get_average(self, products):
        product_values = []
        for product in products:
            product_values.append(int(product.price) * int(product.amount))
        
        return sum(product_values)

    
def create_new_user(path, user):

    with open(path, 'r') as archivo:
        dta = json.load(archivo)

    for _user in dta["users"]:
        if user["username"] == _user["username"]:
            return False
    
    dta["users"].append(user)

    with open(path, 'w') as archivo:
        json.dump({'users' : dta["users"]}, archivo, cls=products.Product_Enconder, indent=4)

    return True

    


#     def menu(self):
#         while True:
#             os.system('clear')
#             print('''       Expensas del mes
            
# 1. Agregar producto
# 2. Consultar productos
# 0. Salir''')
#             opc = input()
#             try:
#                 opc = int(opc)

#             except:
#                 opc = -1

#             if opc == 1:
#                 self.add_products()

#             elif opc == 2:
#                 self.see_products()

#             elif opc == 0:
#                 print('Nos vemos!')
#                 break

#             else:
#                 print("Opcion incorrrecta")

#             input("Presiona enter para continuar...")