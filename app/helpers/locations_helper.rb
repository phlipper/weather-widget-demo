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
      "Data loaded via #{source}."
    end
  end

  def current_temperature(weather, feels_like: false)
    output = [
      content_tag(:span, class: "current-temperature") do
        "#{weather.temp.round(1)} °F"
      end
    ]

    if feels_like
      output << content_tag(:span, class: "current-temperature-feels-like") do
        "(Feels like #{weather.feels_like.round(1)} °F)"
      end
    end

    safe_join(output, "&nbsp;".html_safe)
  end

  def next_12_hourly_items(location)
    # Get the next 12 hourly items - Drop the 1st item (it's the current hour)
    location.weather.hourly.first(13).drop(1)
  end

  def time_label(datetime)
    datetime = Time.zone.at(datetime) if datetime.is_a?(Integer)

    content_tag(:time, datetime: datetime.iso8601) do
      datetime.in_time_zone("Pacific Time (US & Canada)").to_formatted_s(:time)
    end
  end

  def weather_icon_for_location(weather)
    if weather.present?
      weather_icon(weather.weather[0])
    else
      "🤷‍♂️"
    end
  end

  def weather_icon(weather)
    image_tag "https://openweathermap.org/img/wn/#{weather.icon}.png",
      alt: "Weather icon for #{weather.description}",
      class: "weather-icon",
      title: "#{weather.main} (#{weather.description})"
  end

  def weather_updated_at(weather)
    updated_at = Time.zone.at(weather.dt)

    content_tag(:time, datetime: updated_at.iso8601) do
      "Updated #{time_ago_in_words(updated_at)} ago"
    end
  end
end
