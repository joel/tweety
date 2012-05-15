module Async
  
  class << self
    attr_accessor :default_queue_name

    def included(base)
      base.send :include, InstanceMethods
      base.send :extend, ClassMethods
    end
  end

  self.default_queue_name = "async"

  module InstanceMethods
    
    def method_missing(method_name, *args)
      return super unless respond_to?('_' + method_name.to_s)
      Resque.enqueue(self.class, self.id, ('_' + method_name.to_s), *args)
    end
  end
  
  module ClassMethods
    
    def perform(id, method, *args)
      instance = where(id: id).first if where(id: id).exists?
      instance.send(method, *args) if instance
    end
    
    def queue
      @queue || ::Async.default_queue_name
    end

    def queue=(name)
      @queue = name
    end
  end
end