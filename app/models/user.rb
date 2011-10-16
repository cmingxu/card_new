require 'pinyin/pinyin'
class User < ActiveRecord::Base

  acts_as_authentic
  has_many :department_users
  has_many :departments,:through => :department_users
  has_many   :user_powers
  has_many :powers,:through => :user_powers,:conditions => "will_show = 1"
  has_and_belongs_to_many :catenas

  belongs_to :catena
  before_save :geneate_name_pinyin

  def geneate_name_pinyin
    pinyin = PinYin.new
    self.user_name_pinyin = pinyin.to_pinyin(self.user_name) if self.user_name
  end

  after_create :set_powers

  def set_powers
    self.powers = self.departments ? self.departments.collect(&:powers).flatten : []
    self.save
  end


  def is_admin?
    self.login == 'admin'
  end

  #TODO
  def can?(action_name, subject)
    #    return true
    #return true if is_admin?
    #self.roles.include?{|role| role.action == action_name && role.subject == subject }
    flag = false
    #    p_ids = []
    #    UserPower.where(:user_id => self.id).each do  |i|
    #      p_ids << i.power_id
    #    end
    #    Power.where(["id in (?)", p_ids]).each do |u_power|
    #      if u_power.action.eql?(subject + "_" + action_name)
    #        return true
    #      end
    #    end
    return flag
  end


  def department_powers
    self.departments.collect(&:powers).flatten.uniq rescue []
  end
  def menus
    self.powers.collect(&:subject)
  end

  def can_book_when_time_due?
    self.menus.include?("过期预定")
  end

  def can?(action)
    self.menus.include?(action)
  end

end
