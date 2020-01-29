class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id: 1,
        name: 'Vadim',
        username: 'installero',
        avatar_url: 'https://secure.gravatar.com/avatar/' \
          '71269686e0f757ddb4f73614f43ae445?s=100'
      ),
      User.new(id: 2, name: 'Misha', username: 'aristofun')
    ]
  end

  def new
    
  end

  def edit
    
  end

  def show
    @user = User.new(
      name: 'Artem',
      username: 'SuperJerk',
      avatar_url: 'https://placekitten.com/300/400',
    )

    @questions = [
      Question.new(
        text: 'Whats up?',
        created_at: Date.parse('27.03.2020')
      ),
      Question.new(
        text: 'Whats going on?',
        created_at: Date.parse('27.03.2020')
      )
    ]

    @new_question = Question.new
  end
end
