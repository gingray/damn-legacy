# frozen_string_literal: true

describe Damn::Legacy, focus: true do
  context "check DSL enabled" do
    before { Damn::Legacy.turn_on }
    it do
      #noinspection RubyResolve
      kls = NotExistingConst
      expect(kls.meth([:call])).to eq kls
    end
  end
end
