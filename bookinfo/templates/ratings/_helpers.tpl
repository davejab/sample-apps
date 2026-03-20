{{/*
Expand the name of the app.
*/}}
{{- define "ratings.name" }}
{{- default "ratings" .Values.ratings.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ratings.fullname" -}}
{{- if .Values.ratings.fullnameOverride }}
{{- .Values.ratings.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := include "ratings.name" . }}
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
{{- define "ratings.labels" -}}
{{ include "ratings.selectorLabels" . }}
{{ include "bookinfo.labels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ratings.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ratings.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "ratings.serviceAccountName" -}}
{{- if .Values.ratings.serviceAccount.create }}
{{- default (include "ratings.fullname" .) .Values.ratings.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.ratings.serviceAccount.name }}
{{- end }}
{{- end }}
