{{/*
Expand the name of the chart.
*/}}
{{- define "vulcan.name" -}}
{{- default .Chart.Name .Values.vulcan.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "vulcan.fullname" -}}
{{- if .Values.vulcan.fullnameOverride }}
{{- .Values.vulcan.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.vulcan.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "vulcan.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "vulcan.labels" -}}
helm.sh/chart: {{ include "vulcan.chart" . }}
{{ include "vulcan.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "vulcan.selectorLabels" -}}
app.kubernetes.io/name: {{ include "vulcan.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "vulcan.serviceAccountName" -}}
{{- if .Values.vulcan.serviceAccount.create }}
{{- default (include "vulcan.fullname" .) .Values.vulcan.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.vulcan.serviceAccount.name }}
{{- end }}
{{- end }}
