require 'uri'
require 'super_uri'
require 'forwardable'

module URI
  class FILE < Generic

    extend Forwardable
    def_delegators :@path, :basename, :dirname

    def buffer_open(buf, proxy, open_options)
      buf << File.read(path)
      buf.io.rewind
    end

    include OpenURI::OpenRead
  end

  self << FILE
end


