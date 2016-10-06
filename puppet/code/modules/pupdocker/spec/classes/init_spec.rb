require 'spec_helper'
describe 'pupdocker' do
  context 'with default values for all parameters' do
    it { should contain_class('pupdocker') }
  end
end
