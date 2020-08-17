class Bibliography < ActiveRecord::Base
    belongs_to :user
    has_many :citations
    has_many :texts, through: :citations

end