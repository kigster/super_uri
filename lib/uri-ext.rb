require 'uri'

module URI
  # Helper method to hide the hedious @@schemes.
  def self.<<(klass, verb = klass.uri_scheme)
    self.class_variable_set(:@@schemes, {}) unless self.class_variable_get(:@@schemes)
    self.class_variable_get(:@@schemes)[verb.to_s.upcase] = klass
  end
end
