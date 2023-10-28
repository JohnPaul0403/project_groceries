#Main file
#This file is only for the excution of the code

from groceries import Groceries, create_new_user
from flask import Flask, request, jsonify

#Global variable gro, wich will contain the object groceries
gro = None

def main() :
    app = Flask(__name__)
    gro = Groceries()

    @app.route('/')
    def home():
        return "Admin Web Page"
    
    @app.route('/get_status', methods = ["POST"])
    def get_status():
        code = request.get_json()

        if code["code"] == 102:
            return jsonify(
                {
                    "code" : "00",
                    "app_version" : "1.0"
                }
            )
        
        return jsonify({"code" : 10})
    
    @app.route("/get_login", methods = ["POST"])
    def login():
        user = request.get_json()
        user_info = None
        try :
            user_info = gro.get_user(user["username"], user["password"])
        except:
            return jsonify({"code" : 12, "message" : "Problem while trying to login"})
        
        return jsonify(
            {
                "code" : '00', 
                "message" : "success",
                "user_info" : user_info
            }
        )
    
    @app.route("/get_user_data", methods = ["POST"])
    def get_user_data():
        token = request.get_json()
        user_data = gro.get_user_data(token["token"])
        if user_data == False:
            return jsonify(
                {
                    "code" : "12",
                    "message" : "user not found"
                }
            )
        
        return jsonify(
            {
                "code" : "00",
                "message" : "success",
                "data" : user_data
            }
        )
    
    @app.route("/sign_up", methods = ["POST"])
    def sign_up_api():
        new_user = request.get_json()
        user_request = create_new_user("libros.json", new_user)
        if not user_request:
            return jsonify({
                "code" : 12,
                "message" : "Username is already taken"
            })
        
        return jsonify({"code" : "00", "message" : "succes"})

    
    @app.route("/get_products", methods = ["POST"])
    def get_products_api(): 
        user = request.get_json()
        return jsonify(gro.see_products(user["username"]))

    @app.route("/add_products", methods = ["POST"])
    def add_product_api():
        new_product = request.get_json()
        json_product = gro.add_products(new_product["username"], new_product)
        gro.store_products(new_product["username"], "libros.json")
        return jsonify(json_product)

    app.run(host="118.128.222.142", port=8000, debug=True)


if __name__ == "__main__":
    main()