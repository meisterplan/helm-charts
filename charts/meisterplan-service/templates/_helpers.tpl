{{- define "validate-hostname" }}
{{- $hostname := . | default "" }}
{{- if not (regexMatch `^(\*\.)?[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$` $hostname) }}
    {{ fail (printf "Invalid hostname: %s" $hostname) }}
{{- end }}
    {{- $hostname }}
{{- end }}

{{- define "get-private-hostname" }}
{{- include "validate-hostname" (printf "%s.internal.%s" .Release.Name (required "routing.clusterDomain must be set!" .Values.routing.clusterDomain)) }}
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
{{     toYaml $annotations }}
{{- end }}
{{- end }}

{{- define "get-platform" }}
{{- $activePlatforms := 0 }}
{{- range $platformName, $platformConfig := .Values.platform }}
    {{- if $platformConfig.enabled }}
        {{- $activePlatforms = add $activePlatforms 1 }}
        {{- $platformName }}
    {{- end }}
{{- end }}
{{- if eq $activePlatforms 0 }}
{{ fail "You have not activated any platform which this chart is currently not designed to do. Enable the one that applies!" }}
{{- end }}
{{- if gt $activePlatforms 1 }}
{{ fail "You have activated more than 1 platform which this chart is currently not designed to do. Disable the others or deploy multiple releases!" }}
{{- end }}
{{- end }}
