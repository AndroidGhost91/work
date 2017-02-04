module FormsHelper
  def link_to_add_fields(name, f, association, options = {})
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      partial_locals = {
        f: builder,
        association.to_s.singularize.to_sym => builder.object
      }
      render(options.fetch(:resource, '') + association.to_s.singularize + "_fields", partial_locals)
    end

    options = {
      class: 'add_fields',
      data: {
        id: id,
        fields: fields.gsub("\n", "")
      }
    }.deep_merge(options)

    unless options[:class] =~ /add_fields/
      options[:class] += ' add_fields'
    end

    link_to(name, '#', options)
  end
end
