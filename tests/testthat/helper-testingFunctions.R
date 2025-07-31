getdata <- function(dir, name) {
	readRDS(paste("testdata/", dir, "/", name, ".rds", sep = "")) # could move testdata 1 dir lvl up nstead
}

skip_if_py_not_installed <- function(python_packages) {
	for (python_package in python_packages) {
		if (!reticulate::py_module_available(python_package)) {
			testthat::skip(paste(
				"Required Python Module", python_package, "is not available."
			))
		}
	}
}
