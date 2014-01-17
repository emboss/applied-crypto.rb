# cf. https://github.com/ruby/ruby/blob/738c298ce0b832edf5bbd2caed662c1e728a2aa8/lib/securerandom.rb

def random_bytes(n = nil)
  n = n ? n.to_int : 20

  flags = File::RDONLY
  flags |= File::NONBLOCK if defined? File::NONBLOCK
  flags |= File::NOCTTY if defined? File::NOCTTY

  begin
    File.open("/dev/urandom", flags) do |f|
      raise Errno::ENOENT unless f.stat.chardev?

      ret = f.read(n)
      unless ret.length == n
        raise NotImplementedError, "Unexpected partial read from random device: only #{ret.length} for #{n} bytes"
      end

      ret
    end
  rescue Errno::ENOENT
    raise "/dev/urandom not available on this machine"
  end
end

p random_bytes
