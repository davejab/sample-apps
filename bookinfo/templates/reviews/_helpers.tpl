{{/*
Expand the name of the app.
*/}}
{{- define "reviews.name" }}
{{- default "reviews" .Values.reviews.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "reviews.fullname" -}}
{{- if .Values.reviews.fullnameOverride }}
{{- .Values.reviews.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := include "reviews.name" . }}
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
{{- define "reviews.labels" -}}
{{ include "reviews.selectorLabels" . }}
{{ include "bookinfo.labels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "reviews.selectorLabels" -}}
app.kubernetes.io/name: {{ include "reviews.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "reviews.serviceAccountName" -}}
{{- if .Values.reviews.serviceAccount.create }}
{{- default (include "reviews.fullname" .) .Values.reviews.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.reviews.serviceAccount.name }}
{{- end }}
{{- end }}
