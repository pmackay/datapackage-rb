require 'spec_helper'

describe DataPackage::Registry do

  context 'initialize' do

    before(:each) do
      @url = 'http://some-place.com/registry.csv'
      @path = File.join('spec', 'fixtures', 'base_registry.csv')
      @body = File.read(@path)
    end

    it 'accepts urls' do
      FakeWeb.register_uri(:get, @url, :body => @body)

      registry = DataPackage::Registry.new(@url)

      expect(registry.available_profiles.values.count).to eq(1)
      expect(registry.available_profiles['base']).to eq({
          id: 'base',
          title: 'Data Package',
          schema: 'http://example.com/one.json',
          specification: 'http://example.com'
      })
    end

    it 'has a default registry url' do
      default_url = 'http://schemas.datapackages.org/registry.csv'

      FakeWeb.register_uri(:get, default_url, :body => @body)

      registry = DataPackage::Registry.new()

      expect(registry.available_profiles.values.count).to eq(1)
    end

    it 'accepts a path' do
      registry = DataPackage::Registry.new(@path)

      expect(registry.available_profiles.values.count).to eq(1)
      expect(registry.available_profiles['base']).to eq({
          id: 'base',
          title: 'Data Package',
          schema: 'http://example.com/one.json',
          specification: 'http://example.com'
      })
    end

  end

  context 'raises an error' do

    it 'if registry is not a CSV' do
      url = 'http://some-place.com/registry.txt'

      FakeWeb.register_uri(:get, url, :body => "foo")

      expect {
        DataPackage::Registry.new(url)
      }.to raise_error(DataPackage::RegistryError)
    end

    it 'if registry has no ID field' do
      url = 'http://some-place.com/registry.txt'

      FakeWeb.register_uri(:get, url, :body => "foo\nbar")

      expect {
        DataPackage::Registry.new(url)
      }.to raise_error(DataPackage::RegistryError)
    end

    it 'if registry webserver raises error' do
      url = 'http://some-place.com/registry.txt'

      FakeWeb.register_uri(:get, url, :body => "", :status => ["500", "Internal Server Error"])

      expect {
        DataPackage::Registry.new(url)
      }.to raise_error(DataPackage::RegistryError)
    end

    it 'registry url does not exist' do
      url = 'http://some-place.com/registry.txt'

      FakeWeb.register_uri(:get, url, :body => "", :status => ["404", "Not Found"])

      expect {
        DataPackage::Registry.new(url)
      }.to raise_error(DataPackage::RegistryError)
    end

    it 'registry path does not exist' do
      path = "some/fake/path/file.csv"

      expect {
        DataPackage::Registry.new(path)
      }.to raise_error(DataPackage::RegistryError)
    end

  end

  context 'available profiles' do

    it 'available profiles returns empty array when registry is empty' do
      pending
    end

    it 'returns list of profiles' do
      pending
    end

    it 'cannot be set' do
      pending
    end

    it 'works with unicode strings' do
      pending
    end

  end

  context 'get' do

    it 'loads profile from disk' do
      pending
    end

    it 'loads remote file if local copy does not exist' do
      pending
    end

    context 'raises an error' do

      it 'if profile is not json' do
        pending
      end

      it 'remote profile file does not exist' do
        pending
      end

      it 'local profile file does not exist' do
        pending
      end

    end

    it 'returns nil if profile does not exist' do
      pending
    end

    it 'memoizes the profiles' do
      pending
    end

  end

  context 'base path' do

    it 'defaults to the local cache path' do
      pending
    end

    it 'uses received registry base path' do
      pending
    end

    it 'is none if registry is remote' do
      pending
    end

    it 'cannot be set' do
      pending
    end

  end

end
