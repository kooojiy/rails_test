require 'mechanize'

class EventScraping < ApplicationRecord
    def self.scrapeFirst
        for i in 0..45 do
            agent = Mechanize.new
            agent.user_agent_alias = "Mac Safari"
            num = 30 * i + 1
            page = agent.get("https://api.moshicom.com/api/events.xml?entry_status=1&limit=30&start=#{num}")
    
            items = page.search('item')
            items.each do |item|
                title = item.search('title').inner_text
                name = item.search('owner name').inner_text
                date = item.search('started_at').inner_text
                p ("イベント名: #{title}")
                p ("主催者: #{name}")
                p ("日時: #{date}")
                p ('---------------------------------------')
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
            end
        end
    end

    def self.scrapeSecond
        agent = Mechanize.new
        agent.user_agent_alias = "Mac Safari"
        page = agent.get("https://blueshipjapan.com/search/event/catalog")
        elements = page.search('h2.event_title a')

        elements.each do |element|
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
        end
    end
end
