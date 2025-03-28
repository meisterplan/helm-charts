{{- define "is-ingress-public-defined" -}}
{{ and $.Values.ingress.public.subDomain (len $.Values.ingress.public.pathPrefixes) }}
{{- end }}

{{- define "get-ingress-public-host" -}}
{{- if eq $.Values.ingress.public.subDomain "." -}}
{{ required "ingress.clusterDomain must be set!" $.Values.ingress.clusterDomain }}
{{- else -}}
{{ $.Values.ingress.public.subDomain }}.{{ required "ingress.clusterDomain must be set!" $.Values.ingress.clusterDomain }}
{{- end -}}
{{- end }}

{{- define "list-ingress-public-pathPrefixes" -}}
{{- range $prefix := $.Values.ingress.public.pathPrefixes }}
  - path: {{ $prefix }}
    pathType: Prefix
    backend:
      service:
        name: {{ $.Values.serviceName }}
        port:
          number: 80
{{- end }}
{{- end }}
