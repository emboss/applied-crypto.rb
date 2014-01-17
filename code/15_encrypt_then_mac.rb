require 'openssl'
require 'securerandom'
require_relative 'constant_time'

sha = OpenSSL::Digest::SHA256.new

cipher = OpenSSL::Cipher.new("aes-128-cbc")
cipher.encrypt
cipher_key_len = cipher.key_len

# We create a 'master secret' from which we
# will derive the Cipher and the HMAC key.
# Why not handle them as two separate entities?
# Because keeping two things in sync often sucks!

master_length = sha.digest_length + cipher_key_len

master = SecureRandom.random_bytes(master_length)

ckey = master[0...cipher_key_len]
hkey = master[cipher_key_len..-1]

cipher.key = ckey
iv = cipher.random_iv
hmac = OpenSSL::HMAC.new(hkey, sha)

data = "1" * 1000_000
in_data = StringIO.new(data)
enc_data = StringIO.new
buf = String.new

while in_data.read(8192, buf)
  chunk = cipher.update(buf)
  enc_data << chunk
  hmac << chunk
end

last_chunk = cipher.final
enc_data << last_chunk
hmac << last_chunk

tag = hmac.digest

#### Decryption ####

sha = OpenSSL::Digest::SHA256.new
cipher = OpenSSL::Cipher.new("aes-128-cbc")
cipher.decrypt
cipher.key = ckey
cipher.iv = iv
verifier = OpenSSL::HMAC.new(hkey, sha)

in_data = StringIO.new(enc_data.string)
out_data = StringIO.new

while in_data.read(8192, buf)
  verifier << buf
  out_data << cipher.update(buf)
end

out_data << cipher.final

recipient_tag = verifier.digest

begin
  ConstantTime.verify_equal(tag, recipient_tag)
rescue ConstantTime::VerificationError
  # verification failed
  raise
end

puts "Tags matched."
puts data == out_data.string
