from flask import Flask, jsonify
from azure.identity import DefaultAzureCredential
from azure.keyvault.secrets import SecretClient
import os

app = Flask(__name__)

VAULT_URL = os.environ.get("AZURE_KEYVAULT_URL")  # Variable de entorno, nunca hardcodeada

def get_secret(secret_name):
    credential = DefaultAzureCredential()
    client = SecretClient(vault_url=VAULT_URL, credential=credential)
    return client.get_secret(secret_name).value

@app.route("/")
def health():
    return jsonify({"status": "ok"})

@app.route("/secret")
def secret():
    db_conn = get_secret("db-connection")
    return jsonify({"connection": db_conn})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)