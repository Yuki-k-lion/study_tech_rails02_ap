class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  
  has_attached_file :avatar,
                        styles: { medium: "300x300#", thumb: "100x100#" }
  validates_attachment_content_type :avatar,
                        content_type: ["image/jpg","image/jpeg","image/png"]

# 100×100	横100px、縦100pxの画像(アスペクト比を保つ)
# 100×100!	アスペクト比を無視
# 100×100>	一番長い辺を100pxにするようにリサイズ(アスペクト比を保つ)
# 100×100^	一番短い辺を100pxにするようにリサイズ(アスペクト比を保つ)
# 100×100#	アスペクト比を保ち一番短い辺を100pxにするようにリサイズし、画像を中央によせ、はみ出た部分は切り取る
end
