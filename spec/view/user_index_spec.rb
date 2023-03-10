require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
  before do
    user1 = User.create(name: 'John', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'I am a teacher',
                        posts_counter: 1)
    user2 = User.create(name: 'Johni', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'I am a chief',
                        posts_counter: 2)
    user3 = User.create(name: 'Jane', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'I am a speaker',
                        posts_counter: 1)

    @users = [user1, user2, user3]

    visit users_path
  end

  it 'displays the username of all other users' do
    @users.each do |user|
      next if user == @users.first

      expect(page).to have_content(user.name)
    end
  end

  it 'displays the profile picture for each user' do
    @users.each do |user|
      expect(page).to have_css("img[src*='#{user.photo}']")
    end
  end

  it 'displays the number of posts each user has written' do
    @users.each do |user|
      expect(page).to have_content("Number of posts: #{user.posts_counter}")
    end
  end

  it 'redirects to the user show page when a user is clicked' do
    user = @users[2]

    click_link(user.name)

    expect(page).to have_current_path(user_path(user.id))
  end
end
