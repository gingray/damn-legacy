# frozen_string_literal: true

module Damn
  module Legacy
    module DSL
      def const_missing(name)
        const_set(name, Class.new)
      end

      def meth(methods)
        tail = Store.instance.add(self, methods)
        [self, tail]
      end

      def step(&block)
        raise ArgumentError, "No block provided" unless block_given?

        head, = block.call
        if is_a?(Array)
          Store.instance.add(last, head)
        else
          Store.instance.add(self, head)
        end
        self
      end
    end
  end
end
