require("spec_helper")

  describe("#==") do
      it("is the same stylist if it has the same name") do
        stylist1 = Stylist.new({:name => "Richard Ng", :id => nil})
        stylist2 = Stylist.new({:name => "Richard Ng", :id => nil})
        expect(stylist1).to(eq(stylist2))
      end
    end

    describe(".all") do
      it("starts off with no lists") do
        expect(Stylist.all()).to(eq([]))
      end
    end

    describe("#name") do
      it("tells you its name") do
        stylist = Stylist.new({:name => "Richard Ng", :id => nil})
        expect(stylist.name()).to(eq("Richard Ng"))
      end
    end

    describe("#id") do
      it("sets its ID when you save it") do
        stylist = Stylist.new({:name => "Richard Ng", :id => nil})
        stylist.save()
        expect(stylist.id()).to(be_an_instance_of(Fixnum))
      end
    end

     describe("#save") do
      it("lets you save stylists to the database") do
        stylist = Stylist.new({:name => "Richard Ng", :id => nil})
        stylist.save()
        expect(Stylist.all()).to(eq([stylist]))
      end
    end
    
    describe(".find") do
      it("returns a stylist by its ID") do
        test_stylist = Stylist.new({:name => "Richard Ng", :id => nil})
        test_stylist.save()
        test_stylist2 = Stylist.new({:name => "Brian Law", :id => nil})
        test_stylist2.save()
        expect(Stylist.find(test_stylist2.id())).to(eq(test_stylist2))
      end
    end

    describe("#clients") do
      it("returns an array of clients of  stylist") do
        test_stylist = Stylist.new({:name => "Richard Ng", :id => nil})
        test_stylist.save()
        test_client = Client.new({:name => "Brian Law", :stylist_id => test_stylist.id()})
        test_client.save()
        test_client2 = Client.new({:name => "Jeffrey Li", :stylist_id => test_stylist.id()})
        test_client2.save()
        expect(test_stylist.clients()).to(eq([test_client, test_client2]))
      end
    end