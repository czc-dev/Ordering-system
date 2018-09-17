# Define inspection's combination(set)

InspectionSet.create!(set_name: '血算5項目').tap do |i|
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'RBC')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'WBC')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'HB')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'HT')
end

InspectionSet.create!(set_name: '急性期:若里').tap do |i|
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

InspectionSet.create!(set_name: '定期').tap do |i|
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

InspectionSet.create!(set_name: '脂質').tap do |i|
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'T-CHO')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'TG')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'HDL-C')
end

InspectionSet.create!(set_name: '心不全').tap do |i|
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'UA')
end

InspectionSet.create!(set_name: '糖尿病').tap do |i|
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'HBA1C')
end

InspectionSet.create!(set_name: '甲機').tap do |i|
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'FT3')
  i.inspection_details << InspectionDetail.find_by(abbreviation: 'FT4')
end
