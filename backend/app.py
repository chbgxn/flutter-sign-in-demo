from flask import Flask, request, jsonify

app = Flask(__name__)

@app.after_request
def after_request(response):
    response.headers.add('Access-Control-Allow-Origin', '*')
    response.headers.add('Access-Control-Allow-Headers', 'Content-Type,Authorization')
    response.headers.add('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS')
    return response

@app.route('/signin', methods=['POST'])
def sign_in():
    try:
        data = request.get_json()
        if data.get("password") == '123456':
            code = 200
            message = "登录成功"
            info = {
                "token": "next version will add it",
                "userInfo": {
                    "uid": "test001",
                    "email": data.get("email"),
                    "name": "Eddie"
                }
            }
        else:
            code = 201
            message = "登录失败"
            info = {
                "error": "密码错误"
            }
        return jsonify({
            "code": code,
            "message": message,
            "data": info
        })
    
    except Exception as e:
        return jsonify({
            "code": 404, 
            "message": str(e)
        }), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)