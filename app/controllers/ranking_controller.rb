class RankingController < ApplicationController
  layout 'review_site'
  
  before_action :ranking
  
  def ranking
      # @ranking = Product.all.limit(5)
      # limitメソッドも、orderメソッドと同様、allメソッドを省略することができます。
        @ranking = Product.limit(5)
  end
end
