tag_list = %w(
  髪型
  ファッション
  服
  髭
  スキンケア
  美肌
  眉毛
  ムダ毛
  ヘアスタイル
  美容室
  ヘアセット
  コンタクトレンズ
  臭い
  デオドラント
  脱毛
  全身脱毛
  爪
  鼻毛
  口臭
  シェービング
  化粧水
  乳液
  洗顔
  保湿
  ワックス
  コーディネート
  靴
  体型
  筋トレ
  ジョギング
)

tag_list.each do |tag|
  Tag.seed do |s|
    s.tag_name = tag
  end
end