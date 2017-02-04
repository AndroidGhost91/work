module BootstrapHelper

  def alert(name, msg)
    name = name.to_s
    if name =~ /html_safe$/
      name = name.gsub('_html_safe', '')
      msg = msg.html_safe
    end

    content_tag :div, msg, :class => css_classes('alert', "alert-#{alert_class(name)}")
  end

  def bs_panel(heading_text = nil, options = {}, &block)
    if heading_text.present?
      heading = content_tag(:div, heading_text, class: 'panel-heading')
    else
      heading = content_tag(:span)
    end

    body = content_tag(:div, capture(&block), class: 'panel-body')
    options[:class] = css_classes('panel panel-default', options.fetch(:class, nil))
    content_tag(:div, heading + body, options)
  end

  private

  def alert_class(name)
    case name.to_s
    when 'notice'
      'success'
    when 'alert'
      'danger'
    else
      name
    end
  end

  def css_classes(*classes)
    classes.compact.join(' ')
  end

end

