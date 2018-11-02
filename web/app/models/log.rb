class Log < ApplicationRecord
  validates_presence_of :who, :done
end
