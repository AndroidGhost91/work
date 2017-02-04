class Stylesheet < ActiveRecord::Base
  before_validation :create_colors_hash
  default_scope lambda { order(:name) }

  SITE_COLORS = [:base_color, :logo_base_color, :logo_crown_color, :topbar_logo_color, :link_color, :gold_color]

  SITE_COLORS.each do |color|
    attr_writer color
    define_method(color) { colors[color.to_s] }
  end

  def colors
    return {} if read_attribute(:colors).nil?
    @colors ||= JSON.parse(read_attribute(:colors))
  end

  private

  def create_colors_hash
    theme_colors = {}

    SITE_COLORS.each do |color|
      color_value = instance_variable_get("@#{color}")
      next if color_value.blank?
      theme_colors[color] = color_value
    end

    return if theme_colors == {}
    write_attribute(:colors, theme_colors.to_json)
  end
end
