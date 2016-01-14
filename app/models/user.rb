class User < ActiveRecord::Base
  enum role: [:client, :publisher, :admin]
  after_initialize :set_default_role, :if => :new_record?

  has_many :link_requests
  has_many :link_request_offers

  def set_default_role
    self.role ||= :client
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
end
