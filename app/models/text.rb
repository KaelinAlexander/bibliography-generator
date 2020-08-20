class Text < ActiveRecord::Base
    has_many :authors
    has_many :citations
    has_many :bibliographies, through: :citations

    validates :title, presence: true

    accepts_nested_attributes_for :authors
    accepts_nested_attributes_for :bibliographies
    accepts_nested_attributes_for :citations

end