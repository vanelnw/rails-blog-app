require 'rails_helper'

RSpec.describe  'User show page', type: :feature do
    before do
        @user = User.create(name: 'Yaba', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Developer',
        posts_counter: 3)

        @first_post = Post.create(title: 'First', text: 'First post', comments_counter: 1, likes_counter: 1,
                                author: @user)
        @second_post = Post.create(title: 'Second', text: 'Second post', comments_counter: 1, likes_counter: 1,
                                 author: @user)
        @third_post = Post.create(title: 'Third', text: 'Third post', comments_counter: 1, likes_counter: 1,
                                author: @user)

        visit user_path(id: @user.id)
    end

    it "should displays user's profile picture" do
        expect(page).to have_css("img[src*='#{@user.photo}']")
    end

    it "should displays user's name " do
        expect(page).to have_content(@user.name)
    end

    it "should displays the number of posts written by user" do
        expect(page).to have_content(@user.posts_counter)
    end

    it "should display user's bio" do
        expect(page).to have_content(@user.bio)
    end

    it "should display user's first 3 posts" do
        expect(page).to have_content(@first_post.text)
        expect(page).to have_content(@second_post.text)
        expect(page).to have_content(@third_post.text)
    end

    it "should have a button to view all of a user's posts" do
        expect(page).to have_link("See All Posts", href: user_posts_path(user_id: @user.id))
    end

    # it "should redirect to that post's show page" do
    #     # click_link(@first_post.text)
    #     # expect(page).to have_current_path(user_post_path(user_id: @user.id, id: @first_post.id))

    #     post = @user.posts.first
    # click_link post.text
    # expect(current_path).to eq(user_post_path(user_id: @user.id, id: @first_post.id))
    # end

    it 'should redirects to all posts show page.' do
        click_link "See All Posts"
        expect(page).to have_current_path(user_posts_path(user_id: @user.id))
    end

end