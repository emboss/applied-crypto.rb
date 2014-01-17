require 'openssl'

# Because CTR is really a stream cipher - we don't even need
# the stupid #final method...

data = "Applied Crypto.rb"

cipher = OpenSSL::Cipher.new("aes-128-ctr")
cipher.encrypt

key = cipher.random_key
iv = cipher.random_iv

encrypted = cipher.update(data)
p encrypted
puts encrypted.size

decipher = OpenSSL::Cipher.new("aes-128-ctr")
decipher.encrypt # !!!
decipher.key = key
decipher.iv = iv

decrypted = decipher.update(encrypted)
p decrypted
puts decrypted == data
