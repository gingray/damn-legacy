# frozen_string_literal: true

module Damn
  module Legacy
    class Mermaid
      attr_reader :store

      def initialize(store)
        @store = store
      end

      def self.call
        new(Store.instance.store).call
      end

      def call
        header = "stateDiagram-v2"
        buffer = []
        store.each do |k, v|
          v.each do |item|
            buffer << "#{k} --> #{item}"
          end
        end
        [header, buffer.join("\n")].join("\n")
      end
    end
  end
end
