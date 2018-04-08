class Scraping
  def self.movie_urls
    # puts 'get movies link URL'
    # ここに処理を書く
    # 映画の個別ページのURLを取得
    # get_product(link)を呼び出す
    links = [] 
    # 個別ページのリンクを保存する配列

    agent = Mechanize.new
    #新規インスタンスの生成

   next_url = ""
    # パスの部分を変数で定義(はじめは、空）
    
    while true do
    current_page = agent.get("http://review-movie.herokuapp.com" + next_url)
    #ページ情報を格納
    elements = current_page.search('.entry-title a')
    #特定の要素を取ってくる。
    
    elements.each do |ele|
      links << ele.get_attribute('href')
    end
    #タグに記述されている属性を取って、link配列に格納
    
    next_link =  current_page.at('.pagination .next a')
    
    # next_linkがなかったらwhile文を抜ける
    break unless next_link
    #Not good : current_page.search('.next a')
    
    # そのタグからhref属性の値を取得
    next_url = next_link.get_attribute('href')
    
    end

    
    links.each do |link|
        get_product('http://review-movie.herokuapp.com/' + link)
    end
    #return links
    #結果としてlink配列を返す。
    
    return
    
  end

  def self.get_product(link)
      
      
    # agent       =   Mechanize.new
    # #⑦Mechanizeクラスのインスタンスを生成する
    # links       =   link
    # page        =   "http://review-movie.herokuapp.com" + lin
    # #⑧映画の個別ページのURLを取得
    # content     =   agent.get(page)
    # elements    =   content.search('.entry-title a')
    # puts elements
    # title       =   elements.inner_text
    # puts    title
    # #⑨inner_textメソッドを利用し映画のタイトルを取得
    #  elements    =   content.search('.post-image')
    #  puts elements
    #  image_url   =   elements.get_attribute('src')
    # # #⑩image_urlがあるsrc要素のみを取り出す
    #  puts    image_url
    # # product     = Products.new(title: title ,image_url: image_url)
    # # product.save
    # #①①newメソッド、saveメソッドを使い、 スクレイピングした「映画タイトル」と「作品画像のURL」をproductsテーブルに保
    
    agent = Mechanize.new
    page = agent.get(link)
    title = page.at('.entry-title').inner_text
    image_url = page.at('.entry-content img')[:src] if page.at('.entry-content img')
    
    #columnの更新、Rateの追加。
    director = page.at('.director').inner_text if page.at('.director')
   
    detail = page.search('#post-single p').inner_text if page.search('#post-single p')
    
    open_date = page.at('.review_details .date').inner_text if page.at('.review_details .date')
  
    
       #product = Product.new(title: title, image_url: image_url)
    product = Product.where(title: title).first_or_initialize
    
    product.title = title
    product.image_url = image_url
    product.director = director
    product.detail = detail
    product.open_date = open_date
    
    product.save
  end
end



