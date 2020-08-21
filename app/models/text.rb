class Text < ActiveRecord::Base
    has_many :authors
    has_many :citations, dependent: :destroy
    has_many :bibliographies, through: :citations

    accepts_nested_attributes_for :authors
    accepts_nested_attributes_for :bibliographies, reject_if: :all_blank
    accepts_nested_attributes_for :citations

    validates :title, presence: true

end