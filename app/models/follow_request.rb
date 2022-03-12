# == Schema Information
#
# Table name: follow_requests
#
#  id           :integer          not null, primary key
#  status       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipient_id :integer
#  sender_id    :integer
#
class FollowRequest < ApplicationRecord
  belongs_to( :follow_request_recipient, { :class_name => "FollowRequest", :foreign_key => "recipient_id"})
  belongs_to( :follow_request_sender, { :class_name => "FollowRequest", :foreign_key => "sender_id"})
end
