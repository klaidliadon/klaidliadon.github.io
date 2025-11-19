build:
	hugo

run:
	hugo server

pdf:
	@$(foreach f, $(filter-out content/blog/_index.md,$(wildcard content/blog/*.md)), \
		$(eval pdf = "static/downloads/$(subst .md,.pdf,$(notdir $(f)))") \
		echo "$(f) => $(pdf)"; \
		pandoc $(f) \
			--pdf-engine=xelatex \
			-V linkcolor:blue \
			-V geometry:a4paper \
			-V geometry:margin=2cm \
			-V mainfont:"calibri.ttf" \
			-V monofont:"cascadia.ttf" \
			-o $(pdf); \
	)

pkg:
	@$(foreach f, $(filter-out content/pkg/_index.md,$(wildcard content/pkg/*.md)), \
		$(eval dir = $(basename $(notdir $(f)))) \
		mkdir -p ./static/$(dir); \
		$(eval pkg_data = $(shell grep -A4 'go-get:' $(f) | grep 'pkg:' | sed 's/.*"\(.*\)".*/\1/')) \
		$(eval vcs_data = $(shell grep -A4 'go-get:' $(f) | grep 'vcs:' | sed 's/.*"\(.*\)".*/\1/')) \
		$(eval url_data = $(shell grep -A4 'go-get:' $(f) | grep 'url:' | sed 's/.*"\(.*\)".*/\1/')) \
		echo '<html><head><meta name="go-import" content="$(pkg_data) $(vcs_data) $(url_data)"></head></html>' > ./static/$(dir)/index.html; \
	)