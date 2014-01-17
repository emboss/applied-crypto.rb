require 'krypt'
require 'stringio'

io = StringIO.new
hex = Krypt::Hex::Encoder.new(io)
hex << "one\n"
hex << "two\n"
hex << "three\n"
hex.close

result = io.string
puts result

io = StringIO.new(result)
hex = Krypt::Hex::Decoder.new(io)
while (part = hex.read(2))
  print part
end
hex.close
