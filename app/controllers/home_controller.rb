class HomeController < ApplicationController
  def index
    SampleJob.set(wait: 5.seconds).perform_later
  end
end