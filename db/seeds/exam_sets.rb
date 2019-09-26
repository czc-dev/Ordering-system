# Define inspection's combination(set) and group

ExamSet.create!(set_name: '生化学的検査').tap do |exam_set|
  exam_set.exam_items << ExamItem.where(id: 1..55)
end

ExamSet.create!(set_name: '尿・糞便検査').tap do |exam_set|
  exam_set.exam_items << ExamItem.where(id: 56..62)
end

ExamSet.create!(set_name: '血液学的検査').tap do |exam_set|
  exam_set.exam_items << ExamItem.where(id: 63..78)
end

ExamSet.create!(set_name: '耐糖能関連検査').tap do |exam_set|
  exam_set.exam_items << ExamItem.where(id: 79..91)
end

ExamSet.create!(set_name: '免疫学的検査').tap do |exam_set|
  exam_set.exam_items << ExamItem.where(id: 92..121)
end

ExamSet.create!(set_name: 'ウイルス・感染症関連検査').tap do |exam_set|
  exam_set.exam_items << ExamItem.where(id: 122..142)
end

ExamSet.create!(set_name: '腫瘍マーカー').tap do |exam_set|
  exam_set.exam_items << ExamItem.where(id: 143..158)
end

ExamSet.create!(set_name: '甲状腺関連検査').tap do |exam_set|
  exam_set.exam_items << ExamItem.where(id: 159..170)
end

ExamSet.create!(set_name: '内分泌学的検査').tap do |exam_set|
  exam_set.exam_items << ExamItem.where(id: 171..181)
end

ExamSet.create!(set_name: '薬物血中濃度検査').tap do |exam_set|
  exam_set.exam_items << ExamItem.where(id: 171..181)
end

ExamSet.create!(set_name: '血算5項目セット').tap do |exam_set|
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'RBC')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'WBC')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'HB')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'HT')
end

ExamSet.create!(set_name: '急性期:若里セット').tap do |exam_set|
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'TP')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'ALB')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'T-BIL')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'ALP')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'GOT')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'GPT')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'LDH')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'BUN')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'CRE')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'NA')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'K')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'CL')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'UA')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'CA')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'AMY')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'GGTP')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'CPK')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'RBC')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'WBC')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'HB')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'HT')
end

ExamSet.create!(set_name: '定期セット').tap do |exam_set|
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'ALB')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'GOT')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'GPT')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'BUN')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'CRE')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'NA')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'K')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'CL')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'GGTP')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'RBC')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'WBC')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'HB')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'HT')
end

ExamSet.create!(set_name: '脂質セット').tap do |exam_set|
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'T-CHO')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'TG')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'HDL-C')
end

ExamSet.create!(set_name: '心不全セット').tap do |exam_set|
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'UA')
end

ExamSet.create!(set_name: '糖尿病セット').tap do |exam_set|
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'HBA1C')
end

ExamSet.create!(set_name: '甲機セット').tap do |exam_set|
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'FT3')
  exam_set.exam_items << ExamItem.find_by(abbreviation: 'FT4')
end
