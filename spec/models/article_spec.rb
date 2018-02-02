require 'rails_helper'

RSpec.describe Article, type: :model do
	
	# describe "#sum method"  do
	# 	it 'will give 3' do
	# 		expect(Article.sum(1, 2)).to eq(3)
	# 	end
	# end

	it { should validate_presence_of(:title) }
	it { should validate_presence_of(:description) }
	it { should validate_presence_of(:author) }
	it { should belong_to(:user) }

	describe 'custom method' do 
		describe 'search feature' do 
			it 'should search for title, author, and description in the article model' do 
				user = User.create(name: 'asd', email: 'asd@asd.com', password: 'asd')
			
				create = Article.create(title: 'Ruby', description: 'random', author: 'randomauth', user_id: user.id)
				create1 = Article.create(title: 'Ruby', description: 'random', author: 'randomauth', user_id: user.id)
				create2 = Article.create(title: 'Javascript', description: 'random1', author: 'randomauth1', user_id: user.id)

				search = Article.search('Ruby')
				expect(search.count.to_i).to eq(2)
			end
		end
	end

end


