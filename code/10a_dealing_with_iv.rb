require 'openssl'
require 'stringio'

# Prepend the IV at the beginning of the encrypted data

def read_iv(len, io)
  buf = ""
  String.new.tap do |iv|
    until iv.size == len
      part = io.read(len - iv.size, buf)
      iv << buf
    end
  end
end

data = "Applied Crypto.rb" * 100_000
out_enc = StringIO.new

cipher = OpenSSL::Cipher.new("aes-128-cbc")
cipher.encrypt

key = cipher.random_key
iv = cipher.random_iv

out_enc << iv # It's totally fine to transport this in public
out_enc << cipher.update(data) + cipher.final

in_enc = StringIO.new(out_enc.string)
out_data = StringIO.new
decipher = OpenSSL::Cipher.new("aes-128-cbc")
decipher.decrypt
decipher.key = key
decipher.iv = read_iv(decipher.block_size, in_enc)
buf = ""

while in_enc.read(8192, buf)
  out_data << decipher.update(buf)
end
out_data << decipher.final

puts out_data.string == data

