require 'rails_helper'

RSpec.describe User, type: :model do

	it { should validate_presence_of(:name) }
	it { should validate_presence_of(:email) }
	it { should validate_presence_of(:password) }


	describe 'custom method' do 
		describe 'email duplicates' do 
			it 'should check if there are duplicates of emails in user database' do
				user = User.create(name: 'asd', email: 'asd@asd.com', password: 'asd')
				user1 = User.create(name: 'asd', email: 'asd@asd.com', password: 'asd')

				expect(user1.save).to eq(false)
			end
		end
	end

end
