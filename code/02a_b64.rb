require 'base64'

msg = "Applied Crypto.rb"

b64 = Base64.encode64(msg)
puts b64

dec = Base64.decode64(b64)
p dec
