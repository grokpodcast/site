require_relative '../../spec_helper'
require_relative '../../../_lib/tasks/generate'

describe Tasks do
  context 'generate' do
    it 'process the site with Jekyll' do
      jekyll = double('Jekyll')

      Jekyll.should_receive(:configuration).with({}).and_return(:config)
      Jekyll::Site.should_receive(:new).with(:config).and_return(jekyll)
      jekyll.should_receive(:process)

      described_class.generate.should be_true
    end
  end
end