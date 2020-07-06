module ApplicationHelper

  def display_datetime(dt)
    # hard coding this to display for Eastern time. If this was going to be
    # used in an actual live production environment we could use some javascript
    # to ascertain the users timezone so we can set it to their actual local time.
    dt.in_time_zone('Eastern Time (US & Canada)').strftime('%a %I:%M')
  end
end
