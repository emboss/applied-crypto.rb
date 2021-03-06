require_relative 'cryptor'
require 'stringio'

data = "1" * 1000_000
in_data = StringIO.new(data)
enc_data = StringIO.new
buf = String.new

cipher = Encryptor.new("aes-128-cbc")

while in_data.read(8192, buf)
  enc_data << cipher.update(buf)
end
enc_data << cipher.final

decipher = Decryptor.new("aes-128-cbc", key: cipher.key, iv: cipher.iv)
in_enc = StringIO.new(enc_data.string)
out_data = StringIO.new

while in_enc.read(8192, buf)
  out_data << decipher.update(buf)
end
out_data << decipher.final

puts data == out_data.string
