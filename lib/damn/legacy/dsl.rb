# frozen_string_literal: true

module Damn
  module Legacy
    module DSL
      def const_missing(name)
        const_set(name, Class.new)
      end

      def meth(methods)
        Store.instance.add_meth(self, methods)
      end

      def step(&block)
        raise ArgumentError, "No block provided" unless block_given?

        val = block.call
        if !val.nil? && !Store.instance.stack.empty? && self == Store.instance.stack.first[1]
          each do |key|
            Store.instance.add(key, val)
          end
        else
          head, = Store.instance.stack.shift
          if head && is_a?(Array)
            each do |key|
              Store.instance.add(key, head)
            end
          end
        end
        self
      end

      def plot
        Mermaid.call
      end
    end
  end
end
