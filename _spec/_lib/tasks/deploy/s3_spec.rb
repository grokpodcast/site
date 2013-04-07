require_relative '../../../spec_helper'
require_relative '../../../../_lib/tasks/deploy/s3'

describe Tasks::Deploy::S3 do
  let(:task) { described_class }

  before :each do
    task.instance_variable_set :@s3, nil
  end

  describe '#aws_credentials' do
    it 'returns a hash with access_key_id and secret_access_key' do
      expected_credentials = {access_key_id: 'AKIAJTUJGOUJAPL6NWAQ',
                              secret_access_key: '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'}

      task.aws_credentials.should == expected_credentials
    end
  end

  describe '#s3' do
    before :each do
      task.stub(:aws_credentials).and_return(:credentials)

      AWS.should_receive(:config).once.with(:credentials)
      AWS::S3.should_receive(:new).once.and_return(:s3_instance)
    end

    it 'set AWS config with the credentials and return a new S3 instance when called the first time' do
      task.s3.should == :s3_instance
    end

    it 'memoizes the S3 instance when called multiple times' do
      task.s3.should == :s3_instance
      task.s3.should == :s3_instance
    end
  end

  describe "#files_to_deploy" do
    it 'generates a list of files to deploy' do
      File.stub(:file?).and_return(false)
      File.stub(:file?).with('file').and_return(true)

      Dir.should_receive(:glob).with('_site/**/*').and_return(['dir', 'file'])

      task.files_to_deploy.should == ['file']
    end
  end

  describe '#files_from_bucket' do
    it 'should return a hash with object names and etags' do
      remote_object = double(:key => 'objectname', :etag => '"etag"key"')
      bucket = double(:objects => [remote_object])

      files = task.files_from_bucket(bucket)
      files.should == {'objectname' => 'etagkey'}
    end
  end

  describe '#deploy' do
    xit 'copy files to S3'
  end
end