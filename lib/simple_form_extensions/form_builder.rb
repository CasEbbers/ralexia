module ButtonComponents
  def actions(*args, &block)
    template.content_tag :div, class: 'form-group form-actions' do
      template.content_tag :div, class: 'col-sm-offset-2 col-sm-10' do
        yield
      end
    end
  end
end

SimpleForm::FormBuilder.send :include, ButtonComponents
