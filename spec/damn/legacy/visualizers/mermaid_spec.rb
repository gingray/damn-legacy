# frozen_string_literal: true

describe Damn::Legacy::Mermaid do
  context "generate mermaid.js diagram ver 1" do
    before do
      Damn::Legacy.turn_on
      Damn::Legacy.store_clean
      DeductMoney.meth(:prepare).step do
        Mail
      end

      Payment.meth([call: [validate: [check_balance: %i[pay fail]]]]).step do
        DeductMoney.meth(:call).step do
          InformUser.meth(:notify).step do
            Mail
          end
        end
      end
    end
    it "succeeds" do
      expect(plot).to be_a String
    end
  end

  context "generate mermaid.js diagram ver 2" do
    before do
      Damn::Legacy.turn_on
      Damn::Legacy.store_clean
      Api::V1::BatchActionsController.meth([:create]).step do
        BatchActions::Scheduler.meth([:call], args: %i[req resp]).step do
        end
      end
    end
    it "succeeds" do
      expect(plot).to be_a String
    end
  end
end
