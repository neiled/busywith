xml.instruct! :xml, :version=>"1.0"
xml.rss( :version=>"2.0", :"xmlns:atom"=>"http://www.w3.org/2005/Atom" ){
  xml.channel{
    xml.atom( :link, :href => feed_url, :rel => "self", :type => "application/rss+xml" )
  }
}
