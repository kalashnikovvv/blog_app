# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  # Wrappers are used by the form builder to generate a
  # complete input. You can remove any component from the
  # wrapper, change the order or even add your own to the
  # stack. The options given below are used to wrap the
  # whole input.
  config.wrappers :default, class: "b-form_line", error_class: "errors" do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.use :label, class: "b-form_label"

    b.wrapper tag: "div", class: "b-form_field" do |bb|
      bb.use :input, class: "b-form_control"
      bb.use :error, wrap_with: { tag: "span", class: "b-form_error" }
      bb.use :hint,  wrap_with: { tag: "p", class: "b-form_hint" }
    end
  end


  config.wrappers :default_radio_and_checkoboxes, class: "b-form_line", error_class: "errors" do |b|
    b.wrapper tag: "div", class: "b-form_field" do |bb|
      bb.use :input, class: "b-form_control"
      bb.use :error, wrap_with: { tag: "span", class: "b-form_error" }
      bb.use :hint,  wrap_with: { tag: "p", class: "b-form_hint" }
    end
  end


  config.default_wrapper = :default

  config.error_notification_class = "alert alert-danger"
  config.button_class = "btn btn-default b-btn"
  config.boolean_label_class = nil

  config.boolean_label_class = "checkbox"

  config.label_text = lambda { |label, required, explicit_label| "#{label} #{required}" }

  config.browser_validations = false
end
