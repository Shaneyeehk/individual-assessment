class Article < ApplicationRecord
	validates :title, presence: true
	validates :description, presence: true
	validates :author, presence: true
	
	belongs_to :user

	# this commented method below is for reference.
	# def self.sum(a, b)
	# 	a + b
	# end

	def self.search(search)
		if search
			where("title LIKE ? OR description LIKE ? OR author LIKE ?",  "%#{search}%", "%#{search}%","%#{search}%") 
		else	
			all
		end
	end


end
