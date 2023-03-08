require 'rails_helper'

RSpec.describe 'post index page', type: :feature do
  before do
    @user = User.create(name: 'Yaba', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Developer',
                        posts_counter: 1)
    @post = Post.create(title: 'AI', text: 'Great post', comments_counter: 2, likes_counter: 1, author: @user)
    @first_comment = Comment.create(text: 'First comment', author: @user, post: @post)
    @second_comment = Comment.create(text: 'Second comment', author: @user, post: @post)
    Like.create(author: @user, post: @post)

    visit user_posts_path(user_id: @user.id)
  end

  it "should displays user's profile picture" do
    expect(page).to have_css("//img[@src = '#{@post.author.photo}' ]")
  end

  it 'should displays user name' do
    expect(page).to have_content(@post.author.name)
  end

  it 'should displays number of posts the user has written' do
    expect(page).to have_content(@post.author.posts_counter)
  end

  it 'should displays post title' do
    expect(page).to have_content(@post.title)
  end

  it 'should displays post text' do
    expect(page).to have_content(@post.text)
  end

  it 'should displays the first comment' do
    expect(page).to have_content('First comment')
  end

  it 'should displays the number of comments' do
    expect(page).to have_content(@post.comments_counter)
  end

  it 'should displays the number of likes' do
    expect(page).to have_content(@post.likes_counter)
  end

  it 'should displays the pagenation button' do
    expect(page).to have_content('Pagination')
  end

  it "should redirect to that post's show page" do
    click_link @post.text
    expect(page).to have_current_path(user_post_path(user_id: @user.id, id: @post.id))
  end
end
