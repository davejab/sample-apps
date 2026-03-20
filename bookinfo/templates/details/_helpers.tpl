{{/*
Expand the name of the app.
*/}}
{{- define "details.name" }}
{{- default "details" .Values.details.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "details.fullname" -}}
{{- if .Values.details.fullnameOverride }}
{{- .Values.details.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := include "details.name" . }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "details.labels" -}}
{{ include "details.selectorLabels" . }}
{{ include "bookinfo.labels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "details.selectorLabels" -}}
app.kubernetes.io/name: {{ include "details.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "details.serviceAccountName" -}}
{{- if .Values.details.serviceAccount.create }}
{{- default (include "details.fullname" .) .Values.details.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.details.serviceAccount.name }}
{{- end }}
{{- end }}
