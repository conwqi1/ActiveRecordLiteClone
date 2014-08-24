class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |name|
      
      define_method name do
         instance_variable_get("@#{name}")
      end
      
      define_method "#{name}=" do |val|
        instance_variable_set("@#{name}", val)
      end
    #equal to below
    #   def bar=(val)
    #     @bar = val
    #   end
    end
  end
end


# class Foo
#   attr_accessor :bar
# end
#
#
# class Foo
#   def bar
#     @bar
#   end
#   def bar=( new_value )
#     @bar = new_value
#   end
# end