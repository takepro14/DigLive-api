genre_list = %w(
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


genre_list.each do |genre|
  Genre.seed do |s|
    s.genre_name = genre
  end
end