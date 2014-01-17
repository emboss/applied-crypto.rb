require 'krypt'
require 'stringio'

io = StringIO.new
b64 = Krypt::Base64::Encoder.new(io)
b64 << "one\n"
b64 << "two\n"
b64 << "three\n"
b64.close

result = io.string
puts result

io = StringIO.new(result)
b64 = Krypt::Base64::Decoder.new(io)
while (part = b64.read(2))
  print part
end
b64.close
