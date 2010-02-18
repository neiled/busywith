class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.validates_format_of_login_field_options = {:with => /\A\w[\w\.+\-_@]+\z/, :message => I18n.t('error_messages.login_invalid', :default => "should use only letters, numbers and .-_@ please.")}
  end

  attr_accessible :login, :display_name, :email, :password, :password_confirmation, :rpx_identifier

  has_many :projects, :finder_sql => 'SELECT projects.*
                                      FROM projects
                                      JOIN teams ON teams.id = projects.team_id
                                      JOIN memberships ON memberships.team_id = teams.id
                                      JOIN users ON users.id = memberships.user_id
                                      JOIN user_statuses ON users.id = user_statuses.user_id
                                      WHERE users.id = #{id}'
                                      
  has_many :collegues, :class_name => "User", :finder_sql => 'SELECT users.*
                                       FROM users
                                       JOIN memberships ON memberships.user_id = users.id
                                       JOIN teams ON teams.id = memberships.team_id
                                       JOIN memberships mine ON mine.team_id = teams.id
                                       WHERE mine.user_id = #{id} and users.id <> #{id} and mine.accepted_at IS NOT NULL'

  has_many :memberships, :conditions => "accepted_at IS NOT NULL", :dependent => :destroy
  
  has_many :invites, :class_name => "Membership", :conditions => {:accepted_at => nil}

  has_many :all_teams, :through => :memberships, :source => "team", :class_name => "Team"

  has_many :teams, :through => :memberships, :foreign_key => "owner_id",
    :conditions => { :memberships => {:is_administrator => false} }

  has_many :owned_teams, :through => :memberships, :source => "team", :class_name => "Team",
    :conditions => { :memberships => {:is_administrator => true} }
    
  has_many :histories, :order => "created_at desc", :limit => 5
  
  has_one :user_status, :class_name => "UserStatus", :foreign_key => "user_id"
    
  validates_length_of :display_name, :within => 1..50, :message => "must be present"
  
  before_create :setup_defaults
  
  def team_collegues(team)
    User.all(:joins => :memberships, :conditions => { :memberships => { :team_id => team } } )
  end
  
  def collegues_with?(user)
    self == user || collegues.include?(user)
  end
  
  def full_name
    display_name.titlecase
  end
  
  def deliver_password_reset_instructions!  
    reset_perishable_token!  
    UserMailer.deliver_password_reset_instructions(self)  
  end  
  
  private
  
  def setup_defaults
    self.login = self.login.downcase unless self.login.nil?
    self.email = self.email.downcase unless self.email.nil?
    self.user_status = UserStatus.new(:current_task => "Creating Account")
  end
end
