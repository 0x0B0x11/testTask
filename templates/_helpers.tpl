{{/* vim: set filetype=mustache: */}}

{{/*
Selector labels
*/}}
{{- define "testTask.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Chart name and version as used by the chart label
*/}}
{{- define "testTask.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "testTask.labels" -}}
helm.sh/chart: {{ include "testTask.chart" . }}
{{ include "testTask.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Annotation to update pods on Secrets or ConfigMaps updates
*/}}
{{- define "testTask.propertiesHash" -}}
{{- $secrets := include (print $.Template.BasePath "/secrets.yaml") . | sha256sum -}}
{{- $urlConfig := include (print $.Template.BasePath "/urls-config.yaml") . | sha256sum -}}
{{ print $secrets $urlConfig | sha256sum }}
{{- end -}}

{{/*
Name of the service account to use
*/}}
{{- define "testTask.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-") .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Names of backend tier components
*/}}
{{- define "testTask.backend.defaultName" -}}
{{- printf "backend-%s" .Release.Name -}}
{{- end -}}

{{- define "testTask.backend.deployment.name" -}}
{{- default (include "testTask.backend.defaultName" .) .Values.backend.deployment.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "testTask.backend.container.name" -}}
{{- default (include "testTask.backend.defaultName" .) .Values.backend.container.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "testTask.backend.service.name" -}}
{{- default (include "testTask.backend.defaultName" .) .Values.backend.service.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "testTask.backend.hpa.name" -}}
{{- default (include "testTask.backend.defaultName" .) .Values.backend.hpa.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Names of gateway tier components
*/}}
{{- define "testTask.gateway.defaultName" -}}
{{- printf "gateway-%s" .Release.Name -}}
{{- end -}}

{{- define "testTask.gateway.deployment.name" -}}
{{- default (include "testTask.gateway.defaultName" .) .Values.gateway.deployment.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "testTask.gateway.container.name" -}}
{{- default (include "testTask.gateway.defaultName" .) .Values.gateway.container.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "testTask.gateway.service.name" -}}
{{- default (include "testTask.gateway.defaultName" .) .Values.gateway.service.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "testTask.gateway.hpa.name" -}}
{{- default (include "testTask.gateway.defaultName" .) .Values.gateway.hpa.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Names of other components
*/}}
{{- define "testTask.secrets.defaultName" -}}
{{- printf "secrets-%s" .Release.Name -}}
{{- end -}}

{{- define "testTask.urlConfig.defaultName" -}}
{{- printf "url-config-%s" .Release.Name -}}
{{- end -}}

