class Bibliography < ActiveRecord::Base
    belongs_to :user
    has_many :citations, dependent: :destroy
    has_many :texts, through: :citations

    validates :name, presence: true
    validates :style, presence: true

end