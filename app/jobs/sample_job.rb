class SampleJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    puts '5秒経ちました'
  end
end
