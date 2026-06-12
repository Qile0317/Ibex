getdata <- function(dir, name) {
	readRDS(paste("testdata/", dir, "/", name, ".rds", sep = ""))
}

skip_if_py_not_installed <- function(python_packages) {

	missing_packages <- basilisk::basiliskRun(
		env = IbexEnv,
		fun = function(packages) {
			packages[sapply(packages, Negate(reticulate::py_module_available))]
		},
		packages = python_packages
	)

	if (length(missing_packages) > 0) {
		testthat::skip(paste0(
			"Required Python Module",
			if (length(missing_packages) > 1) "s" else "",
			" `",
			paste(missing_packages, collapse = "`, `"),
			"` not available."
		))
	}

}

# Skip an encoder test when the model cannot be fetched from Zenodo (host
# down, 504, truncated body, etc.). External-resource failures must skip,
# not error. A successful call also pre-warms the on-disk model cache.
skip_if_model_unavailable <- function(species = "Human",
								   chain = "Heavy",
								   encoder.input = "atchleyFactors",
								   encoder.model = "VAE") {
	testthat::skip_if_offline()
	ok <- tryCatch({
		Ibex:::aa.model.loader(
			species       = species,
			chain         = chain,
			encoder.input = encoder.input,
			encoder.model = encoder.model
		)
		TRUE
	}, error = function(e) FALSE)
	if (!isTRUE(ok)) {
		testthat::skip(paste0(
			"Encoder model `", species, "_", chain, "_", encoder.model,
			"_", encoder.input, "` could not be downloaded."
		))
	}
}
