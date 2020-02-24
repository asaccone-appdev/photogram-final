# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  comments_count  :integer
#  email           :string
#  is_private      :boolean
#  likes_count     :integer
#  password_digest :string
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  has_many :own_photos, :class_name => "Photo", :foreign_key => "owner_id", :dependent => :destroy
  has_many :received_follow_requests, :class_name => "FollowRequest", :foreign_key => "recipient_id", :dependent => :destroy
  has_many :sent_follow_requests, :class_name => "FollowRequest", :foreign_key => "sender_id", :dependent => :destroy
  has_many :likes, :foreign_key => "fan_id", :dependent => :destroy
  has_many :comments, :foreign_key => "author_id", :dependent => :destroy
  has_many :photos, :through => :likes, :source => :photo
end
