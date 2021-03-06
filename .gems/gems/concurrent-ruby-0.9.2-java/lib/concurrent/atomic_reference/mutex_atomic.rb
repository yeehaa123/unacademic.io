require 'thread'
require 'concurrent/atomic_reference/direct_update'
require 'concurrent/atomic_reference/numeric_cas_wrapper'

module Concurrent

  # @!macro atomic_reference
  #
  # @!visibility private
  # @!macro internal_implementation_note
  class MutexAtomicReference
    include Concurrent::AtomicDirectUpdate
    include Concurrent::AtomicNumericCompareAndSetWrapper

    # @!macro atomic_reference_method_initialize
    def initialize(value = nil)
      @mutex = Mutex.new
      @value = value
    end

    # @!macro atomic_reference_method_get
    def get
      @mutex.synchronize { @value }
    end
    alias_method :value, :get

    # @!macro atomic_reference_method_set
    def set(new_value)
      @mutex.synchronize { @value = new_value }
    end
    alias_method :value=, :set

    # @!macro atomic_reference_method_get_and_set
    def get_and_set(new_value)
      @mutex.synchronize do
        old_value = @value
        @value = new_value
        old_value
      end
    end
    alias_method :swap, :get_and_set

    # @!macro atomic_reference_method_compare_and_set
    def _compare_and_set(old_value, new_value)
      @mutex.synchronize do
        if @value.equal? old_value
          @value = new_value
          true
        else
          false
        end
      end
    end
  end
end
