module Kernel
  def m(obj)
    object_methods = Object.new.methods.sort
    (obj.methods - object_methods).sort
  end
end
