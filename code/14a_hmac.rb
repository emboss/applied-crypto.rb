require 'openssl'
require 'securerandom'
require_relative 'constant_time'

data = "Applied Crypto.rb"

sha = OpenSSL::Digest::SHA256.new
# choose key to be the same size as the
# underlying digest's output length
key = SecureRandom.random_bytes(sha.digest_length)

tag = OpenSSL::HMAC.digest(sha, key, data)

#transport data and tag to recipient

recipient_tag = OpenSSL::HMAC.digest(sha, key, data)

# DO NOT compare with ==

begin
  ConstantTime.verify_equal(tag, recipient_tag)
rescue ConstantTime::VerificationError
  # verification failed
  raise
end

puts "All good"
