class Supplier < ActiveRecord::Base

  #==========================================
  # Associations
  
  belongs_to :address
  has_many   :supplier_products, :dependent => :destroy
  has_many   :products, :through => :supplier_products
  
  has_many   :orders, :class_name => "DropShipOrder", :dependent => :nullify
  
    
  #==========================================
  # Validations
  
  validates_associated :address
  validates :address_id, :name, :phone, :presence => true
  validates :email, :presence => true, :email => true
  validates :url, :url => true

  #==========================================
  # Callbacks
  
  before_validation :save_address, :on => :create
  
  
  
  
  #==========================================
  # Methods
    
  protected
  
    def save_address
      unless address.nil?
        address.phone = phone
        address.save
        write_attribute :address_id, address.id
      end
    end
    
end