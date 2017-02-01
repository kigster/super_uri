class Class
  # For a class name, eg. MyApp::Module::MyClass it attempts to extract a scheme
  # such as 'MYCLASS'.
  def uri_scheme
    name.gsub(/.*::(\w+)$/, '\1').upcase
  end
end
