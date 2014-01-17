module Hex

  module_function

  def encode(s)
    s.unpack("H*").first
  end

  def decode(hex)
    [hex].pack("H*")
  end
end

msg = "Applied Crypto.rb"

hex = Hex.encode(msg)
puts hex

dec = Hex.decode(hex)
p dec
