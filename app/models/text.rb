class Text < ActiveRecord::Base
    has_many :authors
    has_many :citations, dependent: :destroy
    has_many :bibliographies, through: :citations

    accepts_nested_attributes_for :authors
    accepts_nested_attributes_for :citations

    validates :title, presence: true

    def self.untitled
        where(title: nil).or(where(title: ""))
    end

end