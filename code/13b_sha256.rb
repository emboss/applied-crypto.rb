require 'openssl'
require 'stringio'

data = "1" * 1000_000
in_data = StringIO.new(data)
buf = String.new

sha = OpenSSL::Digest::SHA256.new

while in_data.read(8192, buf)
  sha << buf
end

digest = sha.digest # taking no arguments this time

p digest
