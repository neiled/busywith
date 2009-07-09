class User < ActiveRecord::Base
  acts_as_authentic do |c|

    c.validates_format_of_login_field_options = {:with => /\A\w[\w\.+\-_@]+\z/, :message => I18n.t('error_messages.login_invalid', :default => "should use only letters, numbers and .-_@ please.")}

  end

  belongs_to :active_project, :class_name => "Project", :foreign_key => "project_id"
  has_many :projects, :finder_sql => 'SELECT projects.*
                                      FROM projects
                                      JOIN teams ON teams.id = projects.team_id
                                      JOIN memberships ON memberships.team_id = teams.id
                                      JOIN users ON users.id = memberships.user_id
                                      WHERE users.id = #{id}'
                                      
  has_many :collegues, :class_name => "User", :finder_sql => 'SELECT users.*
                                       FROM users
                                       JOIN memberships ON memberships.user_id = users.id
                                       JOIN teams ON teams.id = memberships.team_id
                                       JOIN memberships mine ON mine.team_id = teams.id
                                       WHERE mine.user_id = #{id} and users.id <> #{id}'

  has_many :memberships, :conditions => "accepted_at IS NOT NULL"
  
  has_many :invites, :class_name => "Membership", :conditions => {:accepted_at => nil}

  has_many :all_teams, :through => :memberships, :source => "team", :class_name => "Team"

  has_many :teams, :through => :memberships, :foreign_key => "owner_id",
    :conditions => { :memberships => {:is_administrator => false} }

  has_many :owned_teams, :through => :memberships, :source => "team", :class_name => "Team",
    :conditions => { :memberships => {:is_administrator => true} }
    
  has_many :histories, :order => "created_at desc", :limit => 5
    
  validates_numericality_of :percent_complete, :on => :update, :message => "is not a number"
  validates_date :estimated_completion, :on_or_after => Proc.new {DateTime.now.to_date},
                                        :on_or_after_message => 'must be in the future',
                                        :allow_blank => true
  validates_length_of :current_task, :maximum => 50, :allow_blank => true
  
  before_create :setup_defaults
  
  private
  
  def setup_defaults
    self.percent_complete = 0
  end
end
