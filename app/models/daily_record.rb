class DailyRecord < ApplicationRecord
    include ActiveModel::Dirty
  
    before_save :update_average_ages, if: :male_count_or_female_count_changed?
  
    private
  
    def male_count_or_female_count_changed?
      male_count_changed? || female_count_changed?
    end
  
    def update_average_ages
      self.male_avg_age = User.where(gender: 'male').average(:age).to_f
      self.female_avg_age = User.where(gender: 'female').average(:age).to_f
    end
  end
  