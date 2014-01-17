require 'openssl'

# Danger! Forgetting about the IV
# Don't do this!

data = "Applied Crypto.rb"

cipher = OpenSSL::Cipher.new("aes-128-cbc")
cipher.encrypt

key = cipher.random_key
#iv = cipher.random_iv

encrypted = cipher.update(data) + cipher.final
p encrypted
puts encrypted.size

decipher = OpenSSL::Cipher.new("aes-128-cbc")
decipher.decrypt
decipher.key = key
#decipher.iv = iv

decrypted = decipher.update(encrypted) + decipher.final
p decrypted
puts decrypted == data

# But CBC *needs* an IV - which one does OpenSSL use by default?

decipher = OpenSSL::Cipher.new("aes-128-cbc")
decipher.decrypt
decipher.key = key
decipher.iv = "\x00" * decipher.block_size 

decrypted = decipher.update(encrypted) + decipher.final
p decrypted
puts decrypted == data


