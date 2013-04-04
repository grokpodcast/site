require_relative '../spec_helper'
require_relative '../../_lib/tasks_generate'

describe Tasks do
  context 'generate' do
    it 'process the site with Jekyll' do
      Jekyll.should_receive(:configuration)
            .with(described_class::DEFAULT_CONFIGURATION)
            .and_return(:config)

      jekyll = double('Jekyll')
      Jekyll::Site.should_receive(:new).with(:config).and_return(jekyll)
      jekyll.should_receive(:process)

      described_class.generate.should be_true
    end
  end
end