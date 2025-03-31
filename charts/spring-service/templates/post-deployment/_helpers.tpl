{{- define "is-ingress-public-defined" -}}
{{ and $.Values.ingress.public.subDomain (len $.Values.ingress.public.pathPrefixes) }}
{{- end }}

{{- define "get-ingress-primary-public-host" -}}
{{- if eq $.Values.ingress.public.subDomain "." -}}
{{ required "ingress.clusterDomain must be set!" $.Values.ingress.clusterDomain }}
{{- else -}}
{{ $.Values.ingress.public.subDomain }}.{{ required "ingress.clusterDomain must be set!" $.Values.ingress.clusterDomain }}
{{- end -}}
{{- end }}
