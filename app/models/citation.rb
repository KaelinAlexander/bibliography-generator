class Citation < ActiveRecord::Base
    belongs_to :text
    belongs_to :bibliography
    
end