require 'rails_helper'
require 'mechanize'

RSpec.describe EventScraping, type: :model do
    it "is done to make data enter correctly after scrapingFirst" do
            agent = Mechanize.new
            agent.user_agent_alias = "Mac Safari"
            page = agent.get("https://api.moshicom.com/api/events.xml?entry_status=1&limit=30&start=1")
            item = page.search('item')
            title = item.search('title').inner_text
            name = item.search('owner name').inner_text
            date = item.search('started_at').inner_text
            
            event = Event.new
            event.name = title
            event.owner = name
            event.date = date
            event.site = "e-moshicom"
            if Owner.find_by(name: event.owner) then
                event.link = true
            else
                event.link = false
            end
            event.save
        expect(event).to be_valid
    end

    it "is done to make data enter correctly after scrapingSecond" do
        agent = Mechanize.new
        agent.user_agent_alias = "Mac Safari"
        page = agent.get("https://blueshipjapan.com/search/event/catalog")
        element = page.at('h2.event_title a')

        url = element.get_attribute(:href)
        page = agent.get(url)
        event_name = page.search('section.container h1').inner_text
        event_owner = page.search('table a span').inner_text
        event_date = page.search('div.event_datetime div.left p.value').inner_text

        event = Event.new
        event.name = event_name
        event.owner = event_owner
        event.date = event_date
        event.site = "BlueShip"
        if Owner.find_by(name: event.owner) then
            event.link = true
        else
            event.link = false
        end
        event.save
        expect(event).to be_valid
    end
end