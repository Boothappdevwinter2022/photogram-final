class UsersController < ApplicationController
  
  def index
    @list_of_users = User.all
    render({ :template => "users/index.html.erb"})
  end

  def show
    render({ :template => 'users/show.html.erb"'})
  end
end