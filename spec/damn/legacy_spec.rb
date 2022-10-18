# frozen_string_literal: true

describe Damn::Legacy do
  # noinspection RubyResolve
  let(:kls) { NotExistingConst }
  context "check DSL enabled" do
    before { Damn::Legacy.turn_on }
    it do
      expect(kls.meth([:call])).to eq kls
    end
  end
end
