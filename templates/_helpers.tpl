{{/*
Expand the name of the chart.
*/}}
{{- define "vulcan.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "vulcan.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
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
{{- if .Values.serviceAccount.create }}
{{- default (include "vulcan.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{- define "vulcan.postgresql.fullname" -}}
{{- if .Values.postgresql.fullnameOverride -}}
{{- .Values.postgresql.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.postgresql.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name "vulcan-postgresql" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}


{{/*
Set postgres host
*/}}
{{- define "vulcan.postgresql.host" -}}
{{- if .Values.postgresql.enabled -}}
{{- template "vulcan.postgresql.fullname" . -}}
{{- else -}}
{{- .Values.postgresql.postgresqlHost -}}
{{- end -}}
{{- end -}}

{{/*
Set postgres secret
*/}}
{{- define "vulcan.postgresql.secret" -}}
{{- if .Values.postgresql.enabled -}}
{{- template "vulcan.postgresql.fullname" . -}}
{{- else -}}
{{- template "vulcan.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Set postgres secretKey
*/}}
{{- define "vulcan.postgresql.secretKey" -}}
{{- if .Values.postgresql.enabled -}}
"postgresql-password"
{{- else -}}
{{- default "postgresql-password" .Values.postgresql.auth.secretKeys.adminPasswordKey | quote -}}
{{- end -}}
{{- end -}}

{{/*
Set postgres port
*/}}
{{- define "vulcan.postgresql.port" -}}
{{- if .Values.postgresql.enabled -}}
5432
{{- else -}}
{{- default 5432 .Values.postgresql.postgresqlPort -}}
{{- end -}}
{{- end -}}
