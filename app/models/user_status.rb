class UserStatus < ActiveRecord::Base
  validates_numericality_of :percent_complete, :on => :update, :message => "is not a number"
  validates_date :estimated_completion, :on_or_after => Proc.new {DateTime.now.to_date},
                                        :on_or_after_message => 'must be in the future',
                                        :allow_blank => true
                                        
  validates_presence_of :current_task, :on => :update, :message => "can't be blank"
  validates_length_of :current_task, :maximum => 50
  
  belongs_to :active_project, :class_name => "Project", :foreign_key => "project_id"
  
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  
  before_create :setup_defaults
  
  private
  
  def setup_defaults
    self.percent_complete = 0
  end  
end
