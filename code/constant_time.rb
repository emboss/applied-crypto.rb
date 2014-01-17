require 'openssl'

module ConstantTime

  class VerificationError < StandardError; end

  DIGEST = OpenSSL::Digest::SHA256.new
  private_constant :DIGEST

  module_function

  def verify_equal(s1, s2)
    compare(DIGEST.digest(s1), DIGEST.digest(s2))
  end

  private; module_function

  def compare(s1, s2)
    result = 0
    s1.bytes.each_with_index do |b, i|
      result |= b ^ s2.getbyte(i)
    end
    raise VerificationError unless result == 0
  end

end

