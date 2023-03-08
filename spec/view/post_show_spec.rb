require 'rails_helper'

RSpec.describe "post show page" , type: :feature do
    before do
        @user1 = User.create(name: 'Yaba', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Developer',
        posts_counter: 1)
        @user2 = User.create(name: 'Italo', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Engineer',
                posts_counter: 1)
        @post = Post.create(title: 'AI', text: 'Great post', comments_counter: 2, likes_counter: 1, author: @user1)
        @first_comment = Comment.create(text: 'First comment', author: @user1, post: @post)
        @second_comment = Comment.create(text: 'Second comment', author: @user2, post: @post)
        Like.create(author: @user1, post: @post)

        visit user_post_path(user_id: @user1.id, id: @post.id)
    end

    it 'should displays post title' do
        expect(page).to have_content(@post.title)
      end
  
      it 'should displays post title' do
        expect(page).to have_content(@post.author.name)
      end
  
      it 'should displays the number of comments' do
        expect(page).to have_content(@post.comments_counter)
      end
  
end