require 'openssl'

# reusing the key

def xor(s1, s2)
  String.new.tap do |result|
    s1.bytes.each_with_index do |b, i|
      result << (b ^ s2.getbyte(i))
    end
  end
end

data1 = "the"
data2 = "nyc"

cipher = OpenSSL::Cipher.new("rc4")
cipher.encrypt
key = cipher.random_key 
enc1 = cipher.update(data1)

cipher = OpenSSL::Cipher.new("rc4")
cipher.encrypt
cipher.key = key
enc2 = cipher.update(data2)

p enc1
p enc2

xored = xor(enc1, enc2)
p xored

puts xor(xored, "the")
puts xor(xored, "nyc")
