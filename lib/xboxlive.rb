require 'rubygems'
require 'mechanize'

class XboxLive
  def initialize
     @agent = WWW::Mechanize.new
  end
  
  def login(user, pass)
    page = @agent.get('https://login.live.com')
    form = page.form('f1')
    form.login = user
    form.passwd = pass
    page = @agent.submit(form)
  end
  
  def friends
    page = @agent.get('http://live.xbox.com/en-US/profile/Friends.aspx')
    form = page.form('fmHF')
    page = @agent.submit(form)
    parse(page.body)
  end
  
  def parse(html)
    doc = Nokogiri::HTML(html)
    users = {}
    doc.xpath('//table[@class="XbcProfileTable XbcFriendsListTable"]/tr').each do |friend|
      gamertag = friend.xpath('td[@class="XbcGamerTag"]/a')[0].content
      gamerscore = friend.xpath('td[@class="XbcGamerScore"]/span')[0].content
      presence = friend.xpath('td[@class="XbcGamerPresence"]')[0].content
      description = friend.xpath('td[@class="XbcGamerDescription"]')[0].content
      users.merge!(create_hash(gamertag, gamerscore, presence, description))
    end
    users
  end
  
  def create_hash(gamertag, gamerscore, presence, description)
    hash = {gamertag => {:gamerscore => gamerscore, :presence => presence, :description => description}}
    hash[gamertag].each do |key, val|
      hash[gamertag][key] = "#{val}".strip
    end
    hash
  end
end