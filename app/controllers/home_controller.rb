class HomeController < ApplicationController
  def index
    SampleJob.set(wait: 1.minute).perform_later
  end
end