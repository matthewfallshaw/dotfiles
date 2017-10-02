local logger = hs.logger.new("Utilities")
logger.i("Loading Utilities")

local M = {}

function M.log_and_alert(logger, message)
  logger.i(message)
  hs.alert.show(message)
end

return M
