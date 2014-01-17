require 'openssl'
require 'securerandom'
require_relative 'constant_time'

password = "iforgot"
salt = SecureRandom.random_bytes(16) # at least 8 bytes
iter = 20000 # needs fine-tuning, machine-dependent, but definitely > 1000
digest = OpenSSL::Digest::SHA256.new

# Q: There's no "key" now, so how long should the output be?
# A: Optimal security/performance trade-off: output length of
#    the underlying digest
# Another advantage: you don't need to store this value, it's implicit!
hash_size = digest.digest_length
puts hash_size

# password hash creation
password_hash = OpenSSL::PKCS5.pbkdf2_hmac(password, salt, iter, hash_size, digest)
p password_hash
puts password_hash.size
# now store the password hash along with the salt in your user table

# password hash verification
user_provided_password = "iforgot"
# salt = <salt from database>
# iter = <configuration parameter>
# password_hash = <hash from database>
digest = OpenSSL::Digest::SHA256.new
hash_size = digest.digest_length

my_hash = OpenSSL::PKCS5.pbkdf2_hmac(user_provided_password, salt, iter, hash_size, digest)

begin
  ConstantTime.verify_equal(password_hash, my_hash)
rescue ConstantTime::VerificationError
  # passwords don't match!
  raise
end

puts "Passwords matched"
