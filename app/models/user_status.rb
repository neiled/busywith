class UserStatus < ActiveRecord::Base
  validates_numericality_of :percent_complete, :on => :update, :message => "is not a number"
  validates_date :estimated_completion, :on_or_after => Proc.new {DateTime.now.to_date},
                                        :on_or_after_message => 'must be in the future',
                                        :allow_blank => true
                                        
  validates_presence_of :current_task, :on => :update, :message => "can't be blank"
  validates_length_of :current_task, :maximum => 1000
  
  belongs_to :active_project, :class_name => "Project", :foreign_key => "project_id"
  
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  
  before_create :setup_defaults
  
  attr_accessible :current_task, :estimated_completion, :percent_complete, :project_id
  
  def current_task_trimmed
    unless current_task.empty? || current_task.nil?
      result = current_task.length < 45 ? current_task : current_task[0,45] + "..."
    else
      "No Task Set"
    end    
  end
  
  private
  
  def setup_defaults
    self.percent_complete = 0
  end  
end
