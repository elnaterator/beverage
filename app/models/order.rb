class Order < ActiveRecord::Base
    validates_presence_of :qty, :first, :last, :city, :country
end
