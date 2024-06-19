{{/* vim: set filetype=mustache: */}}

{{/*
Selector labels
*/}}
{{- define "testask.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Chart name and version as used by the chart label
*/}}
{{- define "testask.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "testask.labels" -}}
helm.sh/chart: {{ include "testask.chart" . }}
{{ include "testask.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Annotation to update pods on Secrets or ConfigMaps updates
*/}}
{{- define "testask.propertiesHash" -}}
{{- $secrets := include (print $.Template.BasePath "/secrets.yaml") . | sha256sum -}}
{{- $urlConfig := include (print $.Template.BasePath "/urls-config.yaml") . | sha256sum -}}
{{ print $secrets $urlConfig | sha256sum }}
{{- end -}}

{{/*
Name of the service account to use
*/}}
{{- define "testask.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-") .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Names of backend tier components
*/}}
{{- define "testask.backend.defaultName" -}}
{{- printf "backend-%s" .Release.Name -}}
{{- end -}}

{{- define "testask.backend.deployment.name" -}}
{{- default (include "testask.backend.defaultName" .) .Values.backend.deployment.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "testask.backend.container.name" -}}
{{- default (include "testask.backend.defaultName" .) .Values.backend.container.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "testask.backend.service.name" -}}
{{- default (include "testask.backend.defaultName" .) .Values.backend.service.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "testask.backend.hpa.name" -}}
{{- default (include "testask.backend.defaultName" .) .Values.backend.hpa.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Names of gateway tier components
*/}}
{{- define "testask.gateway.defaultName" -}}
{{- printf "gateway-%s" .Release.Name -}}
{{- end -}}

{{- define "testask.gateway.deployment.name" -}}
{{- default (include "testask.gateway.defaultName" .) .Values.gateway.deployment.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "testask.gateway.container.name" -}}
{{- default (include "testask.gateway.defaultName" .) .Values.gateway.container.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "testask.gateway.service.name" -}}
{{- default (include "testask.gateway.defaultName" .) .Values.gateway.service.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "testask.gateway.hpa.name" -}}
{{- default (include "testask.gateway.defaultName" .) .Values.gateway.hpa.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Names of other components
*/}}
{{- define "testask.secrets.defaultName" -}}
{{- printf "secrets-%s" .Release.Name -}}
{{- end -}}

{{- define "testask.urlConfig.defaultName" -}}
{{- printf "url-config-%s" .Release.Name -}}
{{- end -}}

