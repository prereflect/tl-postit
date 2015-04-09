module ApplicationHelper
  def fix_url(str)
    str.starts_with?('http://' || 'https://') ? str : "http://#{str}"
  end
end
