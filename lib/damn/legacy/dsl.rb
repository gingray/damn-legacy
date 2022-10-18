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
        Store.instance.add(self, val) if val != nil && self.to_s == Store.instance.stack.first
        self
      end

      def plot
        Mermaid.call
      end
    end
  end
end
