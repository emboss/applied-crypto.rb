require 'openssl'

# cf. http://www.ruby-doc.org/stdlib-2.1.0/libdoc/openssl/rdoc/OpenSSL/Cipher.html

cipher = OpenSSL::Cipher.new("aes-128-cbc")
cipher.encrypt

# both methods also set the key and the IV on the instance
key = cipher.random_key
iv = cipher.random_iv
# padding is set to PKCS#5 padding automatically

p key
puts (key.size * 8)

p iv
puts (iv.size)
