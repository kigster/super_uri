
class CaseInsensitiveSymbolizedHash < Hash
  def [](key)
    super(normalize(key))
  end

  def []=(key, value)
    super(normalize(key), value)
  end

  private
  def normalize(key)
    key.to_s.downcase.to_sym
  end
end
