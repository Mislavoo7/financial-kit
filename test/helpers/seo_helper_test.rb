require "test_helper"

class SeoHelperTest < ActionView::TestCase
  include SeoHelper

  test "seo_description strips html and truncates text" do
    desc = "<p>Hello <strong>world</strong> " + ("a" * 200) + "</p>"

    result = seo_description(desc)

    assert_not_includes result, "<p>"
    assert_not_includes result, "<strong>"
    assert result.length <= 150
  end
end
