module ApplicationHelper
  def basic_form_for(record, options = {}, &block)
    options[:html] ||= {}
    options[:html][:class] = "b-form"
    simple_form_for(record, options, &block)
  end
end
