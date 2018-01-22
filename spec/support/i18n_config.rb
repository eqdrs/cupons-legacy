# config for tests
if Rails.env.development? || Rails.env.test?
  I18n.exception_handler = lambda do |_exception, _locale, key, _options|
    raise "missing translation: #{key}"
  end
end
