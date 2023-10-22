#Class Products
#This file is for the creation of your products
#This object will require a name, price per product or 100gr and amount per month
import json
from typing import Any

class Products :
    def __init__(self, name, price, amount) -> None:
        self._name = name
        self._price = price
        self._amount = amount

    @property
    def name(self) :
        return self._name
    
    @name.setter
    def name (self, name):
        self._name = name if name == str else None

    @property
    def price(self) :
        return self._price
    
    @price.setter
    def price (self, price):
        self._price = price if price == str else None

    @property
    def amount(self) :
        return self._amount
    
    @amount.setter
    def amount (self, amount):
        self._amount = amount if amount == str else None

    def __str__(self) -> str:
        return f'''Name: {self._name}
Price: {self._price}
Amount: {self._amount}'''

class Product_Enconder(json.JSONEncoder):
    def default(self, obj) -> Any:
        if isinstance(obj, Products):
            return {"Name" : obj.name, "Price" : obj.price, "Amount" : obj.amount}

        return json.JSONEncoder.default(self, obj)

def Product_decoder(dicc):
    return Products(dicc["Name"], dicc["Price"], dicc['Amount'])