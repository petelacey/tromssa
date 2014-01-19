class SportSelectInput < SimpleForm::Inputs::CollectionInput
  def input
    "#{template.select_tag(attribute_name,
                           template.options_for_select(collection, 1),
                           input_html_options)}".html_safe
  end
end
