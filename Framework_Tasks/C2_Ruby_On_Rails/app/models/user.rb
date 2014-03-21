class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  field :name , :type => String
  field :address, :type => String

  mount_uploader :image, ImageUploader
  validates_presence_of :image,:message=> "You Must Enter a Profile image!"
  
  # field :phone, :type => String
  # validates_presence_of :phone, :message=> "Must enter your Mobile number!"
  # validates_length_of :phone, minimum: 11, maximum: 11, :message=> "Mobile number must be of length 11.."
  # validates_numericality_of :phone, :message=> "Must enter mobile number in numerical form only!"
  # validates_uniqueness_of :phone, :message=> "This mobile number is already associated with another user!"

  attr_accessible :name, :address, :image

  has_many :contacts, class_name: 'Contact', inverse_of: :user_contact


  def search(search)
    all = "All"
    if search == all or search == all.downcase
      return contacts
    else
      return contacts.where( :name => /#{search}/i)
    end
  end


end
