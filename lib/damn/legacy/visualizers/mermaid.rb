# frozen_string_literal: true

require "set"

module Damn
  module Legacy
    class Mermaid
      attr_reader :store, :line_sep

      HEADER = "stateDiagram-v2"

      def initialize(store, line_sep = "\n")
        @store = store
        @line_sep = line_sep
      end

      def self.call
        new(Store.instance.store).call
      end

      def call
        buffer = []
        states = Set.new
        store.each do |k, v|
          v.each do |item|
            states << k
            states << item
            buffer << connection_line(escape_str(k), escape_str(item))
          end
        end
        [HEADER, state_lines(states), buffer.join(line_sep)].join(line_sep)
      end

      private

      def state_lines(states)
        states.map { |state| state_line(state) }.join(line_sep)
      end

      def escape_str(value)
        value.gsub(/[:#]/, "_")
      end

      def connection_line(from, to)
        "#{from} --> #{to}"
      end

      def state_line(state)
        "state \"#{state}\" as #{escape_str(state)}"
      end
    end
  end
end
