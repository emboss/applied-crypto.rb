require 'openssl'
require 'stringio'

data = "1" * 1000_000
in_data = StringIO.new(data)
enc_data = StringIO.new
buf = String.new

cipher = OpenSSL::Cipher.new("aes-128-cbc")
cipher.encrypt

key = cipher.random_key
iv = cipher.random_iv

while in_data.read(8192, buf)
  enc_data << cipher.update(buf)
end

enc_data << cipher.final

in_enc = StringIO.new(enc_data.string)
out_data = StringIO.new

decipher = OpenSSL::Cipher.new("aes-128-cbc")
decipher.decrypt
decipher.key = key
decipher.iv = iv

while in_enc.read(8192, buf)
  out_data << decipher.update(buf)
end

out_data << decipher.final

puts data == out_data.string
