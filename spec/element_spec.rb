require File.expand_path('watirspec/spec_helper', File.dirname(__FILE__))

describe Watir::Element do

  describe '#present?' do
    before do
      browser.goto('file://' + File.expand_path('html/wait.html', File.dirname(__FILE__)))
    end

    it 'returns true if the element exists and is visible' do
      browser.div(:id, 'foo').should be_present
    end

    it 'returns false if the element exists but is not visible' do
      browser.div(:id, 'bar').should_not be_present
    end

    it 'returns false if the element does not exist' do
      browser.div(:id, 'should-not-exist').should_not be_present
    end
  end

  describe "#reset!" do
    it "successfully relocates collection elements after a reset!" do
      element = browser.divs(:id, 'foo').to_a.first
      element.should_not be_nil

      element.send :reset!
      element.should exist
    end
  end

  describe "#exists?" do
    it "should not propagate ObsoleteElementErrors" do
      browser.goto 'file://' + File.expand_path('../html/removed_element.html', __FILE__)

      button  = browser.button(:id => "remove-button")
      element = browser.div(:id => "text")

      element.should exist
      button.click
      element.should_not exist
    end
  end

  describe "#hover" do
    not_compliant_on [:webdriver, :firefox, :synthesized_events], [:webdriver, :ie] do
      it "should hover over the element" do
        browser.goto 'file://' + File.expand_path('../html/hover.html', __FILE__)
        link = browser.a

        link.style("font-size").should == "10px"
        link.hover
        link.style("font-size").should == "20px"
      end
    end
  end

end
