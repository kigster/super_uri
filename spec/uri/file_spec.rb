require File.expand_path('spec/spec_helper')

describe URI::FILE  do
  let(:spec_root) { SuperURI::RSpec.gem_root + '/spec' }
  let(:resource_name) { "#{spec_root}/fixtures/data.json" }
  let(:resource_content) { ::File.read(resource_name) }

  subject(:instance) { URI.parse(uri) }

  describe '#read' do
    let(:uri) { "file://#{resource_name}" }
    its(:read) { should eq resource_content }
  end


  describe '#parse' do
    let(:uri) { 'file:///Volumes/something.pdf' }

    context 'standard port' do
      its(:scheme) { should eq('file') }
      its(:port) { should be_nil }
      its(:host) { should be_nil  }
      its(:user) { should be_nil }
      its(:path) { should eq('/Volumes/something.pdf') }
      its(:class) { should eq(URI::FILE)}
    end

  end
end
