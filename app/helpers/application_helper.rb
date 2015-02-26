module ApplicationHelper
  def pretty_time(full_time)
    full_time = full_time.in_time_zone('Central Time (US & Canada)')
    full_time.strftime("%d-%b-%Y")
  end
end
