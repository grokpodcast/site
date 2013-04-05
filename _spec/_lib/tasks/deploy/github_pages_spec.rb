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

  context 'deploy' do
    it 'creates a temporary directory' do
      Dir.should_receive(:mktmpdir)
      task.deploy
    end

    context 'inside the temporary directory' do
      let(:temp_dir) { double('temp_dir') }

      before :each do
        Dir.should_receive(:mktmpdir).and_yield(temp_dir)
        Dir.stub(:chdir)
      end

      it 'copies the generated static site' do
        task.should_receive(:cp_r).with('_site/.', temp_dir)
        Dir.should_receive(:chdir).with(temp_dir)
        task.deploy
      end

      it 'add .nojekyll file to signal GitHub to not run Jekyll on the site' do
        task.should_receive(:touch).with('.nojekyll')
        described_class.deploy
      end

      it 'setup new git directory and add commit message' do
        Time.stub_chain(:now, :utc).and_return('now')
        expected_message = "Site updated at now".shellescape

        task.should_receive(:system).with('git init')
        task.should_receive(:system).with('git add .')
        task.should_receive(:system).with("git commit -m #{expected_message}")

        described_class.deploy
      end

      it 'pushes the new git repo to branch gh-pages on the configured GitHub repo' do
        task.should_receive(:system).with("git remote add origin git@github.com:#{task::GITHUB_REPONAME}.git")
        task.should_receive(:system).with('git push origin master:refs/heads/gh-pages --force')

        described_class.deploy
      end
    end

  end
end