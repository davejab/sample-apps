{{/*
Expand the name of the app.
*/}}
{{- define "productpage.name" }}
{{- default "productpage" .Values.productpage.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "productpage.fullname" -}}
{{- if .Values.productpage.fullnameOverride }}
{{- .Values.productpage.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := include "productpage.name" . }}
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
{{- define "productpage.labels" -}}
{{ include "productpage.selectorLabels" . }}
{{ include "bookinfo.labels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "productpage.selectorLabels" -}}
app.kubernetes.io/name: {{ include "productpage.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "productpage.serviceAccountName" -}}
{{- if .Values.productpage.serviceAccount.create }}
{{- default (include "productpage.fullname" .) .Values.productpage.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.productpage.serviceAccount.name }}
{{- end }}
{{- end }}
