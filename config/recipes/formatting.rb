def formatters
  [
    { match: /failed/i,      color: :red },
    { match: /keeping/i,     color: :blue },
    { match: /now running/i, color: :cyan }
  ]
end

log_formatter formatters
