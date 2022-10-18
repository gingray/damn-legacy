# frozen_string_literal: true

describe Damn::Legacy::Mermaid do
  context "generate mermaid.js diagram" do
    before do
      Damn::Legacy.turn_on
      Damn::Legacy.store_clean
      frame do
        DeductMoney.meth(:prepare).step do
          Mail
        end
      end

      frame do
        Payment.meth([call: [validate: [check_balance: [:pay]]]]).step do
          DeductMoney.meth(:call).step do
            InformUser.meth(:notify).step do
              Mail.meth(:call).step do
              end
            end
          end
        end
      end
    end
    it "succeeds" do
      # binding.pry
      expect(plot).to be_a String
    end
  end
end
