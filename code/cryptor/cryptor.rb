require 'openssl'
require 'forwardable'

class Cryptor
  extend Forwardable

  attr_reader :key, :iv

  def_delegators :@cipher, :auth_data=, :auth_tag, :auth_tag=, :authenticated?,
                           :update, :final

  alias << update
                            
end
