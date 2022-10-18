module Damn
  module Legacy
    module DSL
      def const_missing(name)
        const_set(name, Class.new)
      end

      def meth(methods)
        Store.instance.add_link(self, methods)
        self
      end

      def c_meth(methods)
        Store.instance.add_link(self, methods)
        self
      end

      def step(&block)
        return self unless block_given?
        val = block.call
        Store.instance.add_link(self, val)
        self
      end
    end
  end
end
