#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Office of Secret Intelligence"
    xml.author "Devin Austin"
    xml.description "Who taught you to be a spy, fucking Gallagher?!"
    xml.link "https://www.stonecolddev.in"
    xml.language "en"

    for article in @posts
      xml.item do
        if article.title
          xml.title article.title
        else
          xml.title ""
        end
        xml.author "Devin Austin"
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.link "https://www.stonecolddev.in/posts/" + article.friendly_id
        xml.guid article.friendly_id

        text = article.body

      end
    end
  end
end
