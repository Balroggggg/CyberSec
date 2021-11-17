from Crypto.Cipher import AES
import base64
import Crypto.Util.Counter
import sys, argparse
from sys import argv
def decode(key, iv, cyphertext):
    ctr = Crypto.Util.Counter.new(128, initial_value=long(iv.encode("hex"), 16))
    cipher = Crypto.Cipher.AES.new(key, Crypto.Cipher.AES.MODE_CTR, counter=ctr)
    return cipher.decrypt(base64.b64decode(cyphertext * (-len(cyphertext) % 4)))
def encode(key, iv, plaintext):
    ctr = Crypto.Util.Counter.new(128, initial_value=long(iv.encode("hex"), 16))
    cipher = Crypto.Cipher.AES.new(key, Crypto.Cipher.AES.MODE_CTR, counter=ctr)
    return base64.b64encode(cipher.encrypt(plaintext))
outf = argv[4]
inf = argv[1]
f = open(inf, 'rb')
text= f.read()
f.close()
key = argv[2]
iv = argv[3]
action = argv[5]
if action == 'd':
    res = decode(key, iv, text)
else:
    res = encode(key,iv,text)
print(res)
with open(outf, "w") as text_file:
    text_file.write(res)
