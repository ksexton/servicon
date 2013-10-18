require 'servicon'

describe Servicon do
  before(:all) do
    @servicon = Servicon::Servicon.new("webserver")
  end
                   
  it "gives a unique id" do
      @servicon.identifier.should eql(
        22704338318629462888122409979625206231270005454074289634515086541537965794865)
  end

  it "create a string" do
      puts @servicon.create
      @servicon.create.class.should eql(String)
  end
  
end
