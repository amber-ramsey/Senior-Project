module TestsHelper
  def humanize(mins)
    output = ""
    if mins > 59
      hours = mins/60
      if hours > 1
        h = " hours "
      else
        h = " hour "
      end
      output = "#{hours}#{h}"
    end
    minutes = mins%60
    if minutes == 0
      m = ""
    elsif minutes > 1
      m = "#{minutes} minutes"
    else
      m = "#{minutes} minute" 
    end
    output += "#{m}"
  end

  def choices(value)
    output = @hash.fetch(value)
  end
end
