# frozen_string_literal: true

require_relative "legacy/version"
require_relative "legacy/dsl"
require_relative "legacy/store"
require_relative "legacy/visualizers/mermaid"

module Damn
  module Legacy
    class Error < StandardError; end

    def self.turn_on
      Object.class.prepend(DSL)
      Object.prepend(DSL)
    end
  end
end
