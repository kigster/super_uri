require_relative '../spec_helper'

# To use this example in tests:
#
# describe URI::FILE do
#   it_should_behave_like "an OpenURI", 'file:///usr/local/etc/my.cnf'
# end

# let(:expected_content) { 'contents of my file' }

shared_examples_for 'an OpenURI' do |uri_source, content, expectation_proc = nil|
  # noinspection RubyArgCount
  subject(:uri) { URI(uri_source) }

  its(:class) { should be_a(URI) }

  its(:scheme) { should_not be_nil }
  its(:scheme) { should eq uri.split('://').first }

  context 'read' do
    before do
      expectation_proc ? expectation_proc.call(self) : nil
    end
    its(:read) { should eq(content) }
  end


end
