#Class Groceries
#This class manage all the groceries while it stores it in a json file
#This will be the first step for the Data Base
import products
import json
import os
import pathlib

class Groceries:
    def __init__(self) -> None:
        self._products = []
        self.get_products("libros.json")

    def __del__(self) -> None :
        self.store_products("libros.json")

    @property
    def products(self):
        return self._products

    @products.setter
    def products(self, arr):
        self._products = arr

    def get_products(self, path):
        path_obj = pathlib.Path(path)  # Convert path to a Path object
        if path_obj.exists():
            with open(path_obj, 'r') as archivo:
                dta = json.load(archivo)

            for product in dta['products']:
                self.products.append(products.Product_decoder(product))

    
    def store_products(self, path):
        with open(path, 'w') as archivo:
            json.dump({'products' : self.products}, archivo, cls=products.Product_Enconder, indent=4)

    def add_products(self):
        os.system("clear")
        name = input("name: ")
        price = input("price: ")
        amount = input("amount: ")
        self.products.append(products.Products(name, price, amount))
        input("Producto agregado! ")
    
    def see_products(self):
        os.system('clear')
        if len(self.products) == 0:
            print("No hay libro")
        else:
            for product in self._products:
                print(f'{product}')
                print("-" * 20)
            
            total_amount = self.get_average()
            
            print(f"Cantidad total: {total_amount}")

    def get_average(self):
        product_values = []
        for product in self.products:
            product_values.append(int(product.price) * int(product.amount))
        
        return sum(product_values)


    def menu(self):
        while True:
            os.system('clear')
            print('''       Expensas del mes
            
1. Agregar producto
2. Consultar productos
0. Salir''')
            opc = input()
            try:
                opc = int(opc)

            except:
                opc = -1

            if opc == 1:
                self.add_products()

            elif opc == 2:
                self.see_products()

            elif opc == 0:
                print('Nos vemos!')
                break

            else:
                print("Opcion incorrrecta")

            input("Presiona enter para continuar...")