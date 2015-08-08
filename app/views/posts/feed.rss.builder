#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title Setting.get("site_text")['settings']["headings"]["site_title"]
    xml.author  Setting.get("site_text")['settings']['owner_name']
    xml.description Setting.get("site_text")["settings"]["headings"]["banner_title"]
    xml.link  Setting.get("site_text")["settings"]["website_url"]
    xml.language "en"

    for article in @posts
      xml.item do
        if article.title
          xml.title article.title
        else
          xml.title ""
        end
        xml.author Setting.get("site_text")['settings']['owner_name']
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.link Setting.get("site_text")["settings"]["website_url"] + "/posts/" + article.friendly_id
        xml.guid article.friendly_id

        text = article.body

      end
    end
  end
end
