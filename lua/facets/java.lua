
local utils = require("user.utils")

utils.ensure_installed({
  "checkstyle",
  "java-debug-adapter",
  "java-test",
  "jdtls",
  "spring-javaformat",
})

-- TODO: https://github.com/mfussenegger/nvim-jdtls
