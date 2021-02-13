module ApplicationHelper
    def default_meta_tags
        {
          site: 'willnote',
          title: 'willnote',
          reverse: true,
          separator: '|',
          description: 'ご自身用にToDoリストを作成出来るアプリです。他にも管理人用のブログも併設しております。',
          keywords: 'ブログ, todo, アプリ, rails',
          canonical: request.original_url,
          noindex: ! Rails.env.production?,
          icon: [
            { href: image_url('favicon.ico') },
            { href: image_url('icon.jpg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
          ],
          og: {
            site_name: 'willnote',
            title: 'willnote',
            description: 'ご自身用にToDoリストを作成出来るアプリです。他にも管理人用のブログも併設しております。', 
            type: 'website',
            url: request.original_url,
            image: image_url('ogp.png'),
            locale: 'ja_JP',
          } 
        }  
    end
end
