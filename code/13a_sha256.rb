require 'openssl'

data = "Applied Crypto.rb"

sha = OpenSSL::Digest::SHA256.new
digest = sha.digest(data)
p digest
puts digest.size

puts sha.digest_length
puts sha.block_length


