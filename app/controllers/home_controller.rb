class HomeController < ApplicationController
  def top
    @events = Event.where(link: true)
  end
end
