# frozen_string_literal: true

require "singleton"
module Damn
  module Legacy
    class Store
      attr_reader :store, :stack

      include Singleton
      def initialize
        init
      end

      def add_meth(from, to)
        val = add(from, to)
        stack.unshift([from.to_s, val])
        val
      end

      def add(from, to)
        return add_array_to_store(from, to, "#") if to.is_a?(Array)
        return add_hash_to_store(from, to, "#") if to.is_a?(Hash)
        return add_sym_to_store(from, to, "#") if to.is_a?(Symbol)

        add_default_to_store(from, to, "#")
      end

      def clean
        init
      end

      private

      def init
        @store = Hash.new { |h, k| h[k] = [] }
        @stack = []
      end

      def add_array_to_store(key, value, glue)
        value.map do |m|
          next add_sym_to_store(key, m, glue) if m.is_a?(Symbol)
          next add_array_to_store(key, m, glue) if m.is_a?(Array)
          next add_hash_to_store(key, m, glue) if m.is_a?(Hash)

          add_default_to_store(key, m, glue)
        end.flatten
      end

      def add_hash_to_store(key, value, glue)
        value.map do |k, v|
          next_key = "#{key}#{glue}#{k}"
          store[key] << next_key
          next add_sym_to_store(next_key, v, glue) if v.is_a?(Symbol)
          next add_hash_to_store(next_key, v, glue) if v.is_a?(Hash)
          next add_array_to_store(next_key, v, glue) if v.is_a?(Array)

          add_default_to_store(next_key, v, glue)
        end.flatten
      end

      def add_sym_to_store(key, value, glue)
        new_value = "#{key}#{glue}#{value}"
        store[key.to_s] << new_value
        [new_value]
      end

      def add_default_to_store(key, value, _glue)
        new_value = value.to_s
        store[key.to_s] << new_value
        store[new_value]
        [new_value]
      end
    end
  end
end
