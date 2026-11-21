{{- define "radarr.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "radarr.labels" -}}
{{ include "radarr.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version }}
{{- end }}

{{/* Without the chart's version, so a release that changes only the chart doesn't restart Radarr. */}}
{{- define "radarr.podLabels" -}}
{{ include "radarr.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}

{{/* A secretKeyRef from a value holding one; takes the value's path and the value. */}}
{{- define "radarr.secretKeyRef" -}}
{{- $path := index . 0 }}
{{- $ref := (index . 1).secretKeyRef }}
secretKeyRef:
  name: {{ required (printf "%s.secretKeyRef.name is required" $path) $ref.name }}
  key: {{ required (printf "%s.secretKeyRef.key is required" $path) $ref.key }}
{{- end }}

{{/* The claim behind a volume; takes the root context and the volume's name. */}}
{{- define "radarr.claimName" -}}
{{- $root := index . 0 }}
{{- $name := index . 1 }}
{{- (index $root.Values.persistence $name).existingClaim | default (printf "%s-%s" $root.Release.Name $name) }}
{{- end }}
