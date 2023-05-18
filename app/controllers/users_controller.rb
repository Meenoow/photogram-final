class UsersController < ApplicationController
  before_action(:force_user_sign_in, only: [:show])

  def index
    users = User.all
    @list_of_users = users.order({ :username => :asc })

    render({ :template => "users/index.html.erb" })
  end

  # redirect if not signed in
  def show
    username = params.fetch("username")
    @the_user = User.where({ :username => username }).first
    @pending_followers = FollowRequest.where({ :recipient_id => @current_user.id }).order({ :created_at => :desc })

    render({ :template => "users/show.html.erb" })
  end

  def liked_photos
    @photos = @current_user.photos

    render({ :template => "users/liked_photos.html.erb" })
  end

  def feed
    user = params.fetch("username")
    matching_user = User.where({ :username => user }).first
    @the_user = matching_user
    @accepted_follow_request_count = @current_user.sentfollowrequests.where({ :status => "accepted" }).count
    @accepted_follow_request = @current_user.sentfollowrequests.where({ :status => "accepted" })
    render({ :template => "users/feed.html.erb" })
  end

  def discover
    render({ :template => "users/discover.html.erb" })
  end
end
