xml.instruct! :xml, :version=>"1.0"
xml.rss( :version=>"2.0") do
  xml.channel do
    xml.title("ImBusyWith.com - #{@user.login}")
    xml.link(history_url(@user.login))
    xml.language("en")
    xml.webMaster("neil@plasticwater.com")
    xml.pubDate(DateTime.now)
    xml.lastBuildDate(DateTime.now)
    for history in @user.histories do
      xml.item do
        xml.title("#{@user.login} #{h(history.message)}")
        xml.link(profile_url(@user.login))
        xml.guid("#{history_url(@user.login)}:#{history.id}")
        xml.pubDate(history.created_at)
        xml.desription(history.message)
      end
    end
  end
end