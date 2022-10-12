module LocationsHelper
  def cache_notice(location)
    if location.weather_is_cached?
      color = "green"
      source = "cache"
    else
      color = "orange"
      source = "API"
    end

    content_tag(:span, style: "color: #{color}; font-style: italic;") do
      "Data loaded via #{source}. " +
      "Cache updated #{time_ago_in_words location.weather_updated_at} ago, " +
      "next update in #{time_ago_in_words location.weather_updated_at + 30.minutes}."
    end
  end

  def date_label(day, day_or_night)
    date = day.to_date
    day_or_night == :day ? day_label(date) : night_label(date)
  end

  def day_label(date)
    if date.today?
      "Today"
    elsif date.tomorrow?
      "Tomorrow"
    else
      date.strftime("%A")
    end
  end

  def night_label(date)
    if date.today?
      "Tonight"
    elsif date.tomorrow?
      "Tomorrow Night"
    else
      "#{date.strftime("%A")} Night"
    end
  end

  def temperature_label(temperature, high_or_low)
    method = high_or_low == :high ? :Maximum : :Minimum
    unit = temperature.public_send(method).Unit
    value = temperature.public_send(method).Value

    "#{value}° #{unit}"
  end

  def weather_icon(forecast)
    image_root = "https://developer.accuweather.com/sites/default/files"
    icon_file = "#{forecast.Icon.to_s.rjust(2, "0")}-s.png"

    image_tag "#{image_root}/#{icon_file}",
      alt: forecast.IconPhrase,
      style: "vertical-align: middle;",
      title: forecast.IconPhrase
  end

  def wind_direction(forecast)
    "#{forecast.Wind.Direction.Localized} at #{forecast.Wind.Speed.Value} " + \
      forecast.Wind.Speed.Unit
  end
end
