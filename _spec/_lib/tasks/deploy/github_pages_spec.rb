require_relative '../../../spec_helper'
require_relative '../../../../_lib/tasks/deploy/github_pages'

describe Tasks::Deploy::GithubPages do
  let(:task) do
    result = described_class
    result.stub(:system) {|arg|   "Executing System: '#{arg}'" }
    result.stub(:cp_r)   {|*args| "Copying: '#{args}'"         }
    result.stub(:touch)  {|arg|   "Touching: '#{arg}'"         }
    result
  end

  before :each do
    task.instance_variable_set :@config, nil
  end

  describe 'TargetRepositoryNotConfigured' do
    it 'has a default error message' do
      exception = task::TargetRepositoryNotConfigured.new
      exception.message.should == "Target repository to deploy to GitHub Pages isn't configured"
    end
  end

  describe '#config' do
    it "loads Jekyll's config" do
      Jekyll.stub(:configuration).with({}).and_return(:config)
      task.config.should == :config
    end

    it "memoizes the result" do
      Jekyll.should_receive(:configuration).with({}).once.and_return(:config)
      task.config.should == :config
      task.config.should == :config
    end
  end

  describe 'payload_directory' do
    it 'gets the payload directory from config' do
      task.stub(:config).and_return({'destination' => :payload})
      task.payload_directory.should == :payload
    end
  end

  describe 'target_repository' do
    it 'gets the target repository from config' do
      task.stub(:config).and_return({'deploy' => {'github_pages' => {'target_repository' => :target}}})
      task.target_repository.should == :target
    end

    it "raises an error if the repo isn't configured" do
      task.stub(:config).and_return({})
      expect { task.target_repository }.to raise_error(task::TargetRepositoryNotConfigured)
    end
  end

  describe '#deploy' do
    it 'creates a temporary directory' do
      Dir.should_receive(:mktmpdir)
      task.deploy
    end

    context 'inside the temporary directory' do
      let(:temp_dir) { double('temp_dir') }

      before :each do
        Dir.stub(:mktmpdir).and_yield(temp_dir)
        Dir.stub(:chdir)
        task.stub(:payload_directory).and_return('stub dir')
        task.stub(:target_repository).and_return('stub repo')
      end

      it 'copies the generated static site' do
        task.stub(:payload_directory).and_return('payload')

        task.should_receive(:cp_r).with('payload', temp_dir)
        Dir.should_receive(:chdir).with(temp_dir)

        task.deploy
      end

      it 'add .nojekyll file to signal GitHub to not run Jekyll on the site' do
        task.should_receive(:touch).with('.nojekyll')
        task.deploy
      end

      it 'setup new git directory and add commit message' do
        Time.stub_chain(:now, :utc).and_return('now')
        expected_message = "Site updated at now".shellescape

        task.should_receive(:system).with('git init')
        task.should_receive(:system).with('git add .')
        task.should_receive(:system).with("git commit -m #{expected_message}")

        task.deploy
      end

      it 'pushes the new git repo to branch gh-pages on the configured GitHub repo' do
        task.stub(:target_repository).and_return('user/repo')

        task.should_receive(:system).with("git remote add origin git@github.com:user/repo.git")
        task.should_receive(:system).with('git push origin master:refs/heads/gh-pages --force')

        task.deploy
      end
    end
  end
end