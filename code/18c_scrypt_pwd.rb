require 'scrypt'

# Password creation
password = SCrypt::Password.create("iforgot")
db_value = password.to_s
p db_value

# Password verification

my_password = SCrypt::Password.new(db_value)
puts my_password == "iforgot"
