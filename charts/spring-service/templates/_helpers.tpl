{{- define "is-ingress-public-defined" -}}
{{ and $.Values.ingress.public.subDomain
    (or $.Values.ingress.public.paths.allowAll
        (not (and (empty $.Values.ingress.public.paths.prefixes) (empty $.Values.ingress.public.paths.exact)))
    )
}}
{{- end }}

{{- define "get-ingress-primary-public-host" -}}
{{- if eq $.Values.ingress.public.subDomain "." -}}
{{ required "ingress.clusterDomain must be set!" $.Values.ingress.clusterDomain }}
{{- else -}}
{{ $.Values.ingress.public.subDomain }}.{{ required "ingress.clusterDomain must be set!" $.Values.ingress.clusterDomain }}
{{- end -}}
{{- end }}

{{- define "k8s.annotations" }}
{{- $annotations := dict }}
{{- if ne .Values.logging.collect true }}
{{-     $_ := set $annotations "com.meisterplan.logs/collect" (printf "%v" .Values.logging.collect) }}
{{- end }}
{{- if ne .Values.logging.retention "default" }}
{{-     $_ := set $annotations "com.meisterplan.logs/retention" .Values.logging.retention }}
{{- end }}
{{- if $annotations }}
{{-     toYaml $annotations }}
{{- end }}
{{- end }}
