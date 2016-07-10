module FeedHelper
  def twitter_feed_display(post)
    text = post.full_text

    # Hashtags
    if post.hashtags?
      post.hashtags.each do |tag|
        ht = "##{tag.text}"
        text = text.gsub(ht, "<a href='https://twitter.com/hashtag/#{tag.text}?src=hash' target='blank'>#{ht}</a>")
      end
    end

    # Links
    if post.urls?
      post.urls.each do |url|
        text = text.gsub(url.url, "<a href='#{url.expanded_url}' target='blank'>#{url.display_url}</a>")
      end
    end

    text.html_safe
  end
end
