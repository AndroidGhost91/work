module LayoutHelper

  def before_container
    content_for(:before_container)
  end

  def add_before_container(&block)
    content_for(:before_container, capture(&block))
  end

  def after_container
    content_for(:after_container)
  end

  def add_after_container(&block)
    content_for(:after_container, capture(&block))
  end

end
