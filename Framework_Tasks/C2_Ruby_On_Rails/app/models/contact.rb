class Contact
  include Mongoid::Document
  attr_accessible :name, :address, :phone,:image, :email ,:mobile
  field :name , :type => String

  field :phone, :type => String
  validates_length_of :phone, minimum: 7, maximum: 8, :message=> "Invalid Phone Number"
  validates_numericality_of :phone, :message=> "Must enter phone number in numerical form only!"
  validates_uniqueness_of :phone, :message=> "This phone number is already associated with another user!"

  field :mobile, :type => String
  validates_length_of :mobile, minimum: 11, maximum: 11, :message=> "Mobile number must be of length 11.."
  validates_numericality_of :mobile, :message=> "Must enter mobile number in numerical form only!"
  validates_uniqueness_of :mobile, :message=> "This mobile number is already associated with another user!"


  field :address, :type => String
  field :email,	:type => String, :default => ""
  
  mount_uploader :image, ImageUploader
  validates_presence_of :image, :message=> "Must add Contact Image"
  
  field :custom_key,	:type => Array, :default => []
  field :custom_value,	:type => Array, :default => []

  belongs_to :user_contact, class_name: 'User', inverse_of: :contacts

  
end
