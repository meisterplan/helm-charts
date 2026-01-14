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
