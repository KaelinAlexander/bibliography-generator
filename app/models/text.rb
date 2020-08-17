class Text < ActiveRecord::Base
    has_many :authors
    has_many :citations
    has_many :bibliographies, through: :citations

end