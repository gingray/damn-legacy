require "singleton"
module Damn
  module Legacy
    class Store
      include Singleton
      def initialize
        @store = Hash.new { |h,k| h[k] = [] }
      end

      def add_link(from, to)
      end

    end
  end
end
