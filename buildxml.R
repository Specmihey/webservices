if(!require("stringr")) install.packages("stringr", repos="http://cran.rstudio.com")
template <- readLines("WebTechnologies.ctv")
pattern <- "pkg>[[:alnum:]]+[[:alnum:].]*[[:alnum:]]+"
out <- paste0(template, collapse = " ")
pkgs <- stringr::str_extract_all(out, pattern)[[1]]
pkgs <- unique(gsub("^pkg>", "", pkgs))
priority <- c('curl','httr','jsonlite','RSelenium','shiny','xml2')
pkgs <- pkgs[ !pkgs %in% priority] # remove priority packages
pkgs <- lapply(as.list(sort(pkgs)), function(x) list(package=x))
output <- 
c(paste0('<CRANTaskView>
  <name>WebTechnologies</name>
  <topic>Web Technologies and Services</topic>
  <maintainer email="thosjleeper@gmail.com">Thomas Leeper, Scott Chamberlain, Patrick Mair, Karthik Ram, Christopher Gandrud</maintainer>
  <version>',Sys.Date(),'</version>'), 
  '  <info>',
  paste0("    ",template), 
  '  </info>',
  '  <packagelist>',
  # list priority packages explicitly
  paste0('    <pkg priority="core">', priority, '</pkg>', collapse = "\n"),
  # add all other packages from `pkgs`
  paste0('    <pkg>', unlist(unname(pkgs)), '</pkg>', collapse = "\n"),
  '  </packagelist>',
  '  <links>',
  '    <a href="https://github.com/ropensci/opendata">Open Data TaskView</a>',
  '  </links>',
  '</CRANTaskView>')

writeLines(output, "WebTechnologies.ctv")
