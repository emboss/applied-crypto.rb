require 'openssl'
require 'securerandom'

password = "iforgot"
salt = SecureRandom.random_bytes(16) # at least 8 bytes
key_size = 16 # = 128 / 8
iter = 20000 # needs fine-tuning, machine-dependent, but definitely > 1000
digest = OpenSSL::Digest::SHA256.new

key = OpenSSL::PKCS5.pbkdf2_hmac(password, salt, iter, key_size, digest)
p key
puts key.size
