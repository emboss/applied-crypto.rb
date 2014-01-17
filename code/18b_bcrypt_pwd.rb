require 'bcrypt'

# Password creation
password = BCrypt::Password.create("iforgot")
db_value = password.to_s
p db_value

# Password verification

my_password = BCrypt::Password.new(db_value)
puts my_password == "iforgot"
