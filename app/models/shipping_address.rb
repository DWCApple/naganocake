class ShippingAddress < ApplicationRecord
  validates :name, presence: true
  #正規表現でハイフンなしの半角７文字という制限
  validates :postal_code, presence: true, uniqueness: true, format: { with: /\A\d{7}\z/ }
  #正規表現で都道府県、市町村を制限
  VARIDATE_ADDRESS = /(...??[都道府県])((?:旭川|伊達|石狩|盛岡|奥州|田村|南相馬|那須塩原|東村山|武蔵村山|羽村|十日町|上越|富山|野々市|大町|蒲郡|四日市|姫路|大和郡山|廿日市|下松|岩国|田川|大村)市|.+?郡(?:玉村|大町|.+?)[町村]|.+?市.+?区|.+?[市区町村])(.+)/
  validates :address, presence: true, uniqueness: true, format: { with: VARIDATE_ADDRESS }

  belongs_to :end_user
end
