SimpleCov.start 'rails' do
  add_filter "/vendor/"

  add_group "Workers", "app/workers"
  add_group "Validators", "app/validators"
end

