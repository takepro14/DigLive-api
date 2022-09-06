# 件数用ダミーデータ
20.times do
  Post.seed do |s|
    s.user_id = rand(1..10)
    s.content = Faker::Lorem.paragraph
  end
end

# 実データに近いデータ
posts_data = [
  {
    jannedaarc:
    {
      youtube_url: 'https://www.youtube.com/watch?v=UkQmLFpYNxs',
      content: '青春の一曲です！キーボードのkiyoさんがめっちゃいい仕事してる。'
    }
  },
  {
    avril:
    {
      youtube_url: 'https://www.youtube.com/watch?v=_P9zR5KaPsc',
      content: '衝撃を受けた一曲'
    }
  },
  {
    slipknot:
    {
      youtube_url: 'https://www.youtube.com/watch?v=QO3j9niG1Og&t=3663s',
      content: 'Dualityが最高'
    }
  },
  {
    xjapan:
    {
      youtube_url: 'https://www.youtube.com/watch?v=KZJpAGCtt28',
      content: 'ライブ見てみたい'
    }
  },
  {
    larcenciel:
    {
      youtube_url: 'https://www.youtube.com/watch?v=g6OlJ8WVPS8',
      content: '個人的にNo.1のPiecesかなと！'
    }
  },
  {
    crossfaith:
    {
      youtube_url: 'https://www.youtube.com/watch?v=zK3tjL0Q_FI',
      content: '海神'
    }
  },
  {
    bringmethehorizon:
    {
      youtube_url: 'https://www.youtube.com/watch?v=Ig7dzqPBHQk',
      content: 'この衣装めっちゃ好き！めっちゃ画質良い'
    }
  },
]

posts_data.each do |data|
  data.values.each do |v|
    Post.seed do |s|
      s.user_id = rand(1..10)
      s.content = v[:content]
      s.youtube_url = v[:youtube_url]
    end
  end
end
