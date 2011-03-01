require 'simple_worker'
require 'hoptoad_notifier'
require 'active_support'
require 'aws'
require 'active_record'

class BaseWorker < SimpleWorker::Base
  attr_accessor :aws_secret_key, :aws_access_key, :s3_suffix

  def initialize
    HoptoadNotifier.configure do |config|
      config.api_key = 'YOUR_HOPTOAD_API_KEY'
    end
  end

end
