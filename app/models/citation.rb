class Citation < ActiveRecord::Base
    belongs_to :text
    belongs_to :bibliography
    accepts_nested_attributes_for :bibliography, reject_if: :all_blank

    validates_uniqueness_of :bibliography_id, :scope => :text_id
    validates :bibliography_id, presence: true
    validates :text_id, presence: true
    
end