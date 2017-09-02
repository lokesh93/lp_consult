class Person
  include ActiveModel::AttributeMethods
 
  define_attribute_methods 'name'
  define_attribute_methods 'email'
  define_attribute_methods 'message'
 
  attr_accessor :name
  attr_accessor :email
  attr_accessor :message
 
end