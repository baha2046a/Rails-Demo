ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
  fragment = Nokogiri::HTML.fragment(html_tag)
  field = fragment.at('input,select,textarea')

  model = instance_tag.object

  html = if field
           field['class'] = "#{field['class']} is-invalid"
           html = <<-HTML
              #{fragment.to_s}
           HTML
           html
         else
           html_tag
         end

  html.html_safe
end