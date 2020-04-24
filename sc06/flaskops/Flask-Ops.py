from flask import Flask
import os
 
app = Flask(__name__)
 
 
@app.route('/')
def hello_whale():
    return "Hello fellow SRE!"

@app.route('/login', methods=['GET'])
def logingc():
    os.system('python autologin-sc.py')
    return "logged into GC!"

if __name__ == '__main__':
   app.run(host="0.0.0.0", port="80") 
