genre_list = %w(
  J-POP
  K-POP
  ポップス
  ロック
  メタル
  パンク
  R&B
  ヒップホップ
  レゲエ
  ファンク
  EDM
  アニメソング
  ボーカロイド
  ジャズ
  クラシック
  カントリー
  アカペラ
  歌謡曲
  ディスコ
  ゲーム音楽
)


genre_list.each do |genre|
  Genre.seed do |s|
    s.genre_name = genre
  end
end