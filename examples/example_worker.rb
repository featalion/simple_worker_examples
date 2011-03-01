class ExampleWorker < BaseWorker

  # merge models from Ruby on Rails app if you want/need it
  #merge File.expand_path('../models/model.rb', File.dirname(__FILE__))

  def run
    begin
      # your code here, SimpleWorker calls this method
    rescue => ex
      HoptoadNotifier.notify(ex)
    end
    log "Woot! It works!"
  end

end
