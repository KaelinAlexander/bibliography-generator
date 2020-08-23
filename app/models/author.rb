class Author < ActiveRecord::Base
    belongs_to :text
    validates :author_type, inclusion: { in: ["author", "editor"] }

end