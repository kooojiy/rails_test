require 'mechanize'

class OwnerScraping < ApplicationRecord
    def self.scrapeFirst
        for i in 1..250000 do
            agent = Mechanize.new
            agent.user_agent_alias = "Mac Safari"
            page = agent.get("https://moshicom.com/user/#{i}/")
        
            tx = page.search('div.progress-box span').inner_text
            next if tx.include?("未評価") or tx==""
        
            elements = page.search('div.d-flex.flex-column h1 span')
            elements.each do |element|
                name = element.inner_text
                next if name.include?("モシコム事務局") or name.include?("退会ユーザー") or name.include?("PICKUP")
                owner = Owner.new
                owner.name = name
                owner.owner_id = i
                owner.site = "e-moshicom"
                owner.save
            end
        end
    end

    def self.scrapeSecond
        for i in 0..170 do
            num = i*18
            agent = Mechanize.new
            agent.user_agent_alias = "Mac Safari"
            page = agent.get("https://blueshipjapan.com/search/crew/catalog?per_page=#{num}")
            elements = page.search('h2.crew_name a')
        
            elements.each do |element|
                url = element.get_attribute(:href)
                page = agent.get(url)
                owner_name = page.search('h1.strong').inner_text
                owner = Owner.new
                owner.name = owner_name
                owner.site = "BlueShip"
                owner.save
            end
        end
    end
end
