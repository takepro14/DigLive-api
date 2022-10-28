# 実データに近いデータ
posts_data = [
  {
    janne_da_arc__dearly__diamond_virgin:
    {
      youtube_url: 'https://www.youtube.com/watch?v=UkQmLFpYNxs',
      content: '音源よりキーボードの音がよく聴こえて良い。なつい。'
    }
  },
  {
    avril_lavigne__first_take__complicated:
    {
      youtube_url: 'https://www.youtube.com/watch?v=_P9zR5KaPsc',
      content: 'FIRST TAKEでこれはうますぎる。'
    }
  },
  {
    vaundy__kataribe:
    {
      youtube_url: 'https://www.youtube.com/watch?v=5p6aQKbIK3E',
      content: 'benefitsライブで聴きたいなー。めっちゃ90年代UKという感じでエモい。'
    }
  },
  {
    slipknot__download_festival:
    {
      youtube_url: 'https://www.youtube.com/watch?v=QO3j9niG1Og&t=3663s',
      content: 'いいなー。Dualityが最高。'
    }
  },
  {
    xjapan__lunatic_fest:
    {
      youtube_url: 'https://www.youtube.com/watch?v=KZJpAGCtt28',
      content: '神フェス'
    }
  },
  {
    larc_en_ciel__larcasino__pieces:
    {
      youtube_url: 'https://www.youtube.com/watch?v=g6OlJ8WVPS8',
      content: '個人的にNo.1のPiecesです!なんというか美しい・・'
    }
  },
  {
    crossfaith__coldrain__sataniccarnival:
    {
      youtube_url: 'https://www.youtube.com/watch?v=w6T68iG49Vs',
      content: 'この二人のFaintは本当にめっちゃクオリティ高い！！！'
    }
  },
  {
    bring_me_the_horizon__rock_am_ring:
    {
      youtube_url: 'https://www.youtube.com/watch?v=Ig7dzqPBHQk',
      content: '衣装と髪型が気に入ってます！MANTRA〜HOUSE OF WOLVES〜medicineの流れが最高'
    }
  },
  {
    utada_hikaru__laughter_in_the_dark__automatic:
    {
      youtube_url: 'https://www.youtube.com/watch?v=i3ZRyq1c-Zo',
      content: 'メンバー紹介から歌に入る流れが好き。'
    }
  },
  {
    king_gnu__studio_live:
    {
      youtube_url: 'https://www.youtube.com/watch?v=dP8VC-422es',
      content: 'スタジオセッション良い！'
    }
  },
  {
    one_ok_rock__mighty_long_fall__kanzen_kankaku_dreamer:
    {
      youtube_url: 'https://www.youtube.com/watch?v=VMD0hp8Po3o',
      content: 'ライブでこの歌唱力すごい'
    }
  },
  {
    marilyn_manson__unknown__this_is_the_new_shit:
    {
      youtube_url: 'https://www.youtube.com/watch?v=JY9a_xuv13g',
      content: '狂気。この頃のテイストめっちゃ好きだった。Tim Scold製'
    }
  },
  {
    bump_of_chicken__aurora_ark__aurora:
    {
      youtube_url: 'https://www.youtube.com/watch?v=M2bQzkg8R8A',
      content: '始まり方が最高。フェイクも最高。'
    }
  },
  {
    ed_sheeran__carpool_karaoke:
    {
      youtube_url: 'https://www.youtube.com/watch?v=ckdsJ-LaCvM',
      content: '相方も普通にうまいw'
    }
  },
  {
    hyde__teru__jack_in_the_box:
    {
      youtube_url: 'https://www.youtube.com/watch?v=4LlKf9HCC1I',
      content: '奇跡のコラボ'
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
