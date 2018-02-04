module TestHelper
  def self.wait_until_present(page_element)
    sleep 100 until page_element.visible?
  end
end
