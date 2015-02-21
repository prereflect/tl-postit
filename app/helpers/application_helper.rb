module ApplicationHelper
  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end

  def display_datetime(dt)
    dt.strftime("%m/%d/%Y <span class='quiet'>at</span> %l:%M%P %Z").html_safe
  end
end
