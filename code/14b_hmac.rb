require 'openssl'
require 'securerandom'
require_relative 'constant_time'

data = "1" * 1000_000
in_data = StringIO.new(data)
buf = String.new

sha = OpenSSL::Digest::SHA256.new
# choose key to be the same size as the
# underlying digest's output length
key = SecureRandom.random_bytes(sha.digest_length)
hmac = OpenSSL::HMAC.new(key, sha)

while in_data.read(8192, buf)
  hmac << buf
end

tag = hmac.digest

#transport data and tag to recipient
in_data = StringIO.new(data)
hmac = OpenSSL::HMAC.new(key, sha)

while in_data.read(8192, buf)
  hmac << buf
end

recipient_tag = hmac.digest

# DO NOT compare with ==

begin
  ConstantTime.verify_equal(tag, recipient_tag)
rescue ConstantTime::VerificationError
  # verification failed
  raise
end

puts "All good"
