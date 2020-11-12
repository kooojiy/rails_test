require 'rails_helper'
require 'mechanize'

RSpec.describe EventScraping, type: :model do
    it "is done to make owner data enter correctly after scrapingFirst" do
        
            agent = Mechanize.new
            agent.user_agent_alias = "Mac Safari"
            page = agent.get("https://moshicom.com/user/1/")
        
            tx = page.search('div.progress-box span').inner_text
            next if tx.include?("未評価") or tx==""
        
            element = page.at('div.d-flex.flex-column h1 span')
            name = element.inner_text
            next if name.include?("モシコム事務局") or name.include?("退会ユーザー") or name.include?("PICKUP")
            owner = Owner.new
            owner.name = name
            owner.owner_id = 1
            owner.site = "e-moshicom"
            owner.save
        expect(owner).to be_valid
    end

    it "is done to make owner data enter correctly after scrapingSecond" do
            agent = Mechanize.new
            agent.user_agent_alias = "Mac Safari"
            page = agent.get("https://blueshipjapan.com/search/crew/catalog?per_page=1")
            element = page.at('h2.crew_name a')

            url = element.get_attribute(:href)
            page = agent.get(url)
            owner_name = page.search('h1.strong').inner_text
            owner = Owner.new
            owner.name = owner_name
            owner.site = "BlueShip"
            owner.save
        expect(owner).to be_valid
    end
end