from flask import Flask
from flask import request
import os
import pexpect
 
app = Flask(__name__)
 
 
@app.route('/')
def hello_whale():
    return "Hello fellow SRE!"

@app.route('/login', methods=['GET'])
def logingc():
    ##child = pexpect.spawn('kubectl vsphere login --server=kubeapi.corp.local --vsphere-username administrator@vsphere.local --insecure-skip-tls-verify')
    child = pexpect.spawn('kubectl vsphere login --server=10.10.20.129 --vsphere-username administrator@vsphere.local --insecure-skip-tls-verify')
    child.expect('Password:')
    child.sendline('VMware1!')
    err = child.read()
    return err
    #child = pexpect.spawn('kubectl get ns')
    #err = child.read()
    #print err
    #child = pexpect.spawn('kubectl get po')
    #err = child.read()
    #print err
    #return "logged into GC!"

@app.route('/getns', methods=['GET'])
def getnsgc():
    ##child = pexpect.spawn('kubectl vsphere login --server=kubeapi.corp.local --vsphere-username administrator@vsphere.local --insecure-skip-tls-verify')
    child = pexpect.spawn('kubectl get ns')
    err = child.read()
    return err

@app.route('/getpo', methods=['GET'])
def getpogc():
    ##child = pexpect.spawn('kubectl vsphere login --server=kubeapi.corp.local --vsphere-username administrator@vsphere.local --insecure-skip-tls-verify')
    child = pexpect.spawn('kubectl get po')
    err = child.read()
    return err

@app.route('/createguestcluster', methods=['GET','POST'])
def creategc():
    ##child = pexpect.spawn('kubectl vsphere login --server=kubeapi.corp.local --vsphere-username administrator@vsphere.local --insecure-skip-tls-verify')
    if request.method == 'POST':
        data = request.form # a multidict containing POST dat
    child = pexpect.spawn('kubectl get svc')
    err = child.read()
    return err
    if request.method == 'GET':
        data = request.form # a multidict containing POST dat
    child = pexpect.spawn('kubectl get sc')
    err = child.read()
    return err

@app.route('/form-example', methods=['GET', 'POST']) #allow both GET and POST requests
def form_example():
    if request.method == 'POST':  #this block is only entered when the form is submitted
        language = request.form.get('language')
        framework = request.form['framework']

        return '''<h1>The language value is: {}</h1>
                  <h1>The framework value is: {}</h1>'''.format(language, framework)

    return '''<form method="POST">
                  Language: <input type="text" name="language"><br>
                  Framework: <input type="text" name="framework"><br>
                  <input type="submit" value="Submit"><br>
              </form>'''

if __name__ == '__main__':
   app.run(host="0.0.0.0", port="80") 
