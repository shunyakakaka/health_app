class Board < ApplicationRecord

  has_many :board_tag_relations, dependent: :delete_all
  has_many :tags, through: :board_tag_relations
  belongs_to :user
  
  validates :before_weight, presence: true
  validate :comma_check_before_weight
  validates :after_weight, presence: true
  validate :comma_check_after_weight


  private
  
  def comma_check_before_weight
    if  before_weight !~ /\A[-]?[0-9]+(\.[0-9]+)?\z/
      errors.add(:before_weight, "は半角数字と小数点で入力してください")
      
    end
  end

  def comma_check_after_weight
    if after_weight !~ /\A[-]?[0-9]+(\.[0-9]+)?\z/
      errors.add(:after_weight, "は半角数字と小数点で入力てください")
    end
  end
end
