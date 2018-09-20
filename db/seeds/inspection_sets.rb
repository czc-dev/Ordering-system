# Define inspection's combination(set) and group

InspectionSet.create!(set_name: '生化学的検査').tap do |i|
  i.inspection_details << InspectionDetail.where(id: 1..55)
end

InspectionSet.create!(set_name: '尿・糞便検査').tap do |i|
  i.inspection_details << InspectionDetail.where(id: 56..62)
end

InspectionSet.create!(set_name: '血液学的検査').tap do |i|
  i.inspection_details << InspectionDetail.where(id: 63..78)
end

InspectionSet.create!(set_name: '耐糖能関連検査').tap do |i|
  i.inspection_details << InspectionDetail.where(id: 79..91)
end

InspectionSet.create!(set_name: '免疫学的検査').tap do |i|
  i.inspection_details << InspectionDetail.where(id: 92..121)
end

InspectionSet.create!(set_name: 'ウイルス・感染症関連検査').tap do |i|
  i.inspection_details << InspectionDetail.where(id: 122..142)
end

InspectionSet.create!(set_name: '腫瘍マーカー').tap do |i|
  i.inspection_details << InspectionDetail.where(id: 143..158)
end

InspectionSet.create!(set_name: '甲状腺関連検査').tap do |i|
  i.inspection_details << InspectionDetail.where(id: 159..170)
end

InspectionSet.create!(set_name: '内分泌学的検査').tap do |i|
  i.inspection_details << InspectionDetail.where(id: 171..181)
end

InspectionSet.create!(set_name: '薬物血中濃度検査').tap do |i|
  i.inspection_details << InspectionDetail.where(id: 171..181)
end

InspectionSet.create!(set_name: '血算5項目セット').tap do |i|
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'RBC')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'WBC')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'HB')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'HT')
end

InspectionSet.create!(set_name: '急性期:若里セット').tap do |i|
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'TP')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'ALB')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'T-BIL')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'ALP')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'GOT')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'GPT')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'LDH')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'BUN')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'CRE')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'NA')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'K')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'CL')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'UA')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'CA')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'AMY')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'GGTP')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'CPK')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'RBC')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'WBC')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'HB')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'HT')
end

InspectionSet.create!(set_name: '定期セット').tap do |i|
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'ALB')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'GOT')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'GPT')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'BUN')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'CRE')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'NA')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'K')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'CL')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'GGTP')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'RBC')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'WBC')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'HB')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'HT')
end

InspectionSet.create!(set_name: '脂質セット').tap do |i|
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'T-CHO')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'TG')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'HDL-C')
end

InspectionSet.create!(set_name: '心不全セット').tap do |i|
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'UA')
end

InspectionSet.create!(set_name: '糖尿病セット').tap do |i|
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'HBA1C')
end

InspectionSet.create!(set_name: '甲機セット').tap do |i|
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'FT3')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'FT4')
end
