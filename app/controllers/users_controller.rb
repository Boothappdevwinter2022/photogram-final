class UsersController < ApplicationController
  
  def index
    @list_of_users = User.all
    render({ :template => "users/index.html.erb"})
  end

  def show
    p_username = params.fetch("a_username")
    @the_user = User.where({ :username => p_username}).at(0)
    @follow_request_received = FollowRequest.where({ :recipient_id => @the_user.id})
    @follow_request_sent = FollowRequest.where({ :sender_id => @the_user.id})
    @follow_request_received_accepted = @follow_request_received.where({ :status => "accepted"})
    @follow_request_sent_accepted = @follow_request_sent.where({ :status => "accepted"})
    render({ :template => "users/show.html.erb"})
  end
end