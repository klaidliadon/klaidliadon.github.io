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