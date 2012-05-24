module Async
  extend ActiveSupport::Concern

  module InstanceMethods
    
    def method_missing(method_name, *args)
      return super unless respond_to?('_' + method_name.to_s)
      begin
        Resque.enqueue(self.class, self.id, ('_' + method_name.to_s), *args)
      rescue Errno::ECONNREFUSED => e
        Rails.logger.error e.message
        self.send(('_' + method_name.to_s).to_sym, *args)
      end
    end
  end
  
  module ClassMethods
    
    def perform(id, method, *args)
      instance = where(id: id).first if where(id: id).exists?
      instance.send(method, *args) if instance
    end
    
    def queue
      @queue || '*'
    end

    def queue=(name)
      @queue = name
    end
  end
end