module TestHelper
  def self.wait_until_present(page_element)
    sleep 100 until page_element.visible?
  end

  def self.random
    (0...10).map { ('a'..'z').to_a[rand(26)] }.join
  end
end
