+++ 
date = {{ .Date }}
title = ""
url = ""
description = ""
categories = [{{ range $taxonomyname, $taxonomy := .Site.Taxonomies.categories }}"{{ $taxonomyname }}",{{ end }}]
tags = [{{ range $taxonomyname, $taxonomy := .Site.Taxonomies.tags }}"{{ $taxonomyname }}",{{ end }}]
+++
