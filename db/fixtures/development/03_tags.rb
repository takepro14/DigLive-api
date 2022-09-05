tag_list = %w(
  J-POP
  ロック
  K-POP
  EDM
  アニメソング
  ボーカロイド
  ポップス
  ジャズ
  クラシック
  ラテン
  ブラックミュージック
  R&B
  ヒップホップ
  ブルース
  レゲエ
  スカ
  メタル
  アカペラ
  演歌
  ディスコソング
)

tag_list.each do |tag|
  Tag.seed do |s|
    s.tag_name = tag
  end
end