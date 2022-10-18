# frozen_string_literal: true

describe Damn::Legacy::Mermaid do
  context "generate mermaid.js diagram" do
    before do
      Damn::Legacy.turn_on
      Damn::Legacy::Store.instance.clean

      Payment.meth([call: [validate: [check_balance: [:pay]]]]).step do
        DeductMoney.meth(:call).step do
          InformUser.meth(:notify).step do
            Mail.meth(:call).step do
            end
          end
        end
      end
    end
    it "succeeds" do
      code = Damn::Legacy::Mermaid.call
      expect(code).to be_a String
    end
  end
end
