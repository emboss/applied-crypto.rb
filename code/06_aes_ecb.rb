require 'openssl'

# cf. http://www.ruby-doc.org/stdlib-2.1.0/libdoc/openssl/rdoc/OpenSSL/Cipher.html

def block_print(enc)
  rest = enc.dup
  while rest != ""
    p rest.slice!(0, 16)
  end
end

data = ( ("\x00" * 16) << ("\x01" * 16) ) * 10

cipher = OpenSSL::Cipher.new("aes-128-ecb")
cipher.encrypt

key = cipher.random_key
# no IV

# We normally need the call to final for padding to work.
# Since in this case we're acting on data that is an exact
# multiple of the block size, we could omit it, though.
encrypted = cipher.update(data) + cipher.final
block_print(encrypted)

decipher = OpenSSL::Cipher.new("aes-128-ecb")
decipher.decrypt
decipher.key = key

decrypted = decipher.update(encrypted) + decipher.final
puts decrypted == data

# view the padding
decipher = OpenSSL::Cipher.new("aes-128-ecb")
decipher.decrypt
decipher.key = key
decipher.padding = 0

decrypted = decipher.update(encrypted)
block_print(decrypted)
