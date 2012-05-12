module Async
  def self.included(base)
    base.send(:extend, ClassMethods)
  end

  module ClassMethods
    # This will be called by a worker when a job needs to be processed
    def perform(id, method, *args)
      instance = find_by_id(id)
      instance.send(method, *args) if instance
    end

    def queue
      :general
    end
  end

  # We can pass this any Repository instance method that we want to
  # run later.
  def async(method, *args)
    begin
      Resque.enqueue(self.class, id, method, *args)
    rescue Errno::ECONNREFUSED => e
      Rails.logger.error e.message
      self.class.perform(id, method, *args)
    end
  end
end