class ReviewsController < RankingController
  before_action :authenticate_user!, only: :new 
# 「before_actionメソッドは、呼び出される際第一引数にシンボル型でメソッド名、第二引数以降にハッシュ型でオプションを受け取るメソッドである」
# アソシエーションの時に利用したhas_manyやbelongs_toといったものも同様に考えられます。
  
  def new
    @product = Product.find(params[:product_id])
    @review = Review.new
  end

  def create
     Review.create(create_params)
    
    # トップページにリダイレクトする
    redirect_to controller: :products, action: :index
  end

  private
  def create_params
    params.require(:review).permit(:nickname,:rate, :reviews).merge(product_id: params[:product_id])
  end
end
