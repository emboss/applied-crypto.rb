require 'securerandom'

one_time_token = SecureRandom.random_bytes(20)
p one_time_token
puts one_time_token.size

one_time_token = SecureRandom.hex(20)
puts one_time_token
puts one_time_token.size

one_time_token = SecureRandom.base64(20)
puts one_time_token
puts one_time_token.size

puts SecureRandom.urlsafe_base64(20)
