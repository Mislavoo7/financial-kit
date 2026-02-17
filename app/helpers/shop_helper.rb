module ShopHelper
  def transrom_name_to_color(name)
    hash = name.each_char.inject(0) do |memo, char|
      (memo << 7) - memo + char.ord
    end

    r = (hash.abs * 56) % 255
    g = (hash.abs * 89) % 255
    b = (hash.abs * 117) % 255

    r = [[r, 0].max, 255].min
    g = [[g, 0].max, 255].min
    b = [[b, 0].max, 255].min

    "rgb(#{r}, #{g}, #{b})"
  end
end
