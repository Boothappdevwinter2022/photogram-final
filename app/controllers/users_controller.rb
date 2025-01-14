class UsersController < ApplicationController
  def index
    @list_of_users = User.all
    render({ :template => "users/index.html.erb" })
  end

  def owned_photo
    @p_username = params.fetch("a_username")
    @the_user = User.where({ :username => @p_username }).at(0)

    @follow_request_received = FollowRequest.where({ :recipient_id => @the_user.id })
    @follow_request_sent = FollowRequest.where({ :sender_id => @the_user.id })

    @follow_request_received_accepted = @follow_request_received.where({ :status => "accepted" })
    @follow_request_sent_accepted = @follow_request_sent.where({ :status => "accepted" })

    @follow_request_received_pending = @follow_request_received.where({ :status => "pending" })
    # @follow_request_sent_pending = @follow_request_sent.where({ :status => "pending"})

    # @follow_request_received_rejected = @follow_request_received.where({ :status => "rejected"})
    # @follow_request_sent_rejected = @follow_request_sent.where({ :status => "rejected"})

    if @current_user.nil? == true
      redirect_to("/user_sign_in", { :notice => "You have to sign in first." })
    else
      @current_follower = @follow_request_received_accepted.where(:sender_id => @current_user.id).at(0)
      if @current_user.id == @the_user.id
        render({ :template => "users/show_owned_photo.html.erb" })
      else
        if @the_user.private == false
          render({ :template => "users/show_owned_photo.html.erb" })
        else
          if @current_follower.nil? == false
            render({ :template => "users/show_owned_photo.html.erb" })
          else
            redirect_to("/users", { :alert => "You're not authorized for that." })
          end
        end
      end
    end
  end

  def liked_photo
    @p_username = params.fetch("a_username")
    @the_user = User.where({ :username => @p_username }).at(0)

    @follow_request_received = FollowRequest.where({ :recipient_id => @the_user.id })
    @follow_request_sent = FollowRequest.where({ :sender_id => @the_user.id })

    @follow_request_received_accepted = @follow_request_received.where({ :status => "accepted" })
    @follow_request_sent_accepted = @follow_request_sent.where({ :status => "accepted" })

    @photo_likes = Like.where({ :fan_id => @the_user.id }).map(&:photo_id)
    @liked_photos = Photo.where({ id: @photo_likes })

    render({ :template => "users/show_liked_photo.html.erb" })
  end

  def discover
    @p_username = params.fetch("a_username")
    @the_user = User.where({ :username => @p_username }).at(0)

    @follow_request_received = FollowRequest.where({ :recipient_id => @the_user.id })
    @follow_request_sent = FollowRequest.where({ :sender_id => @the_user.id })

    @follow_request_received_accepted = @follow_request_received.where({ :status => "accepted" })
    @follow_request_sent_accepted = @follow_request_sent.where({ :status => "accepted" })

    @followed_ids = @follow_request_sent_accepted.map(&:recipient_id)
    @likes_by_followed_photos = Like.where(fan_id: @followed_ids)
    @liked_photos = Photo.where(id: @likes_by_followed_photos)

    render({ :template => "/users/show_discover.html.erb" })
  end

  def feed
    @p_username = params.fetch("a_username")
    @the_user = User.where({ :username => @p_username }).at(0)

    @follow_request_received = FollowRequest.where({ :recipient_id => @the_user.id })
    @follow_request_sent = FollowRequest.where({ :sender_id => @the_user.id })

    @follow_request_received_accepted = @follow_request_received.where({ :status => "accepted" })
    @follow_request_sent_accepted = @follow_request_sent.where({ :status => "accepted" })

    @followed_ids = @follow_request_sent_accepted.map(&:recipient_id)
    @followed_photos = Photo.where( owner_id: @followed_ids )

    render({ :template => "/users/show_feed.html.erb" })
  end
end
