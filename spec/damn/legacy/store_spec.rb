# frozen_string_literal: true

describe Damn::Legacy::Store do
  let(:service) { Damn::Legacy::Store.send(:new) }
  describe "Damn::Legacy::Store#add" do
    context "pass symbol as method argument" do
      it "succeeds" do
        service.add("LovelyClass", :call)
        expect(service.store).to eq({ "LovelyClass" => ["LovelyClass#call"] })
      end
    end

    context "pass class as method argument" do
      it "succeeds" do
        cls = Class.new
        str_cls = cls.to_s
        service.add("LovelyClass", cls)
        expect(service.store).to eq({ "LovelyClass" => [str_cls], str_cls => [] })
      end
    end

    context "pass array of symbols as method argument" do
      it "succeeds" do
        service.add("LovelyClass", %i[call1 call2])
        expect(service.store).to eq({ "LovelyClass" => ["LovelyClass#call1", "LovelyClass#call2"] })
      end
    end

    context "pass array of arrays as method argument" do
      it "succeeds" do
        service.add("LovelyClass", [:call1, [[]]])
        expect(service.store).to eq({ "LovelyClass" => ["LovelyClass#call1"] })
      end
    end

    context "pass array of hashes and arrays as method argument" do
      it "succeeds" do
        service.add("LovelyClass", [:call1, { call2: %i[call3 call4] }])
        expect(service.store).to eq({ "LovelyClass" => ["LovelyClass#call1", "LovelyClass#call2"],
                                      "LovelyClass#call2" => ["LovelyClass#call2#call3", "LovelyClass#call2#call4"] })
      end
    end
  end
end
