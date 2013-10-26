require 'servicon'

# Goal:
#
# icon = Servicon::Icon.new("webserver", color = 1, ascii = 1)
#
# puts icon.uuid
# puts icon.matrix
# puts icon.display
# puts icon.html


describe Servicon do
  before(:all) do
    @servicon = Servicon::Icon.new("webserver")
  end
                   
  it "displays the unique id" do
      @servicon.uuid.should eql(
        22704338318629462888122409979625206231270005454074289634515086541537965794865)
  end
  
  it "displays the matrix" do
      @servicon.matrix.count.should eql(8)
  end

  it "displays the servicon" do
      @servicon.display.should eql(8)
  end

  
end
