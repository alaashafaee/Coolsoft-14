class Contact
  include Mongoid::Document
  attr_accessible :name, :address, :phone,:image
  field :name , :type => String

  field :phone, :type => String
  validates_presence_of :phone, :message=> "Must enter your Mobile number!"
  validates_length_of :phone, minimum: 7, maximum: 8, :message=> "Mobile number must be of length 11.."
  validates_numericality_of :phone, :message=> "Must enter mobile number in numerical form only!"
  validates_uniqueness_of :phone, :message=> "This mobile number is already associated with another user!"

  field :address, :type => String
  field :email,	:type => String, :default => ""
  mount_uploader :image, ImageUploader

  field :custom_key,	:type => Array, :default => []
  field :custom_value,	:type => Array, :default => []

  belongs_to :user_contact, class_name: 'User', inverse_of: :contacts

  def create_contact contact
  		c = Contact.new
  		c.name = @contact.name
  		c.phone = @contact.phone
  		c.address = @contact.address
  		c.email = @contact.email
  		c.user_contact = current_user

  		if c.save
        return true
      else
        return false
      end
  end

  def add_hash(contact,hash_for_custom_fields)
    if hash_for_custom_fields
        hash_for_custom_fields.each do |key, value|
          contact.custom_key << key
          contact.value << value
        end
      end
  end

  def custom_is_empty(contact)
    if contact.custom_key.blank? || contact.custom_value.blank?
      return true
    end
    return false
  end

  def getHash(contact)
    i = 0
    hash_arry = [] 
    if contact.custom_is_empty(contact)
      while i < contact.custom_key.count
        hash_arry << {contact.key.at(i) => contact.vlaue.at(i)}
      end
    end
  end

end
