{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "common.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Expand the version of the chart.
*/}}
{{- define "common.version" -}}
{{- default .Chart.Version | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Expand the namespace of the chart.
*/}}
{{- define "common.namespace" -}}
{{- default .Chart.Name .Values.namespaceOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Expand the maintainer of the chart.
*/}}
{{- define "common.managed-by" -}}
{{- if .Values.image.maintainer -}}
{{- .Values.image.maintainer | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- default .Values.image.repository | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Expand the sidecar injection of the chart.
*/}}
{{- define "common.sidecar_inject" -}}
{{- if .Values.sidecar_inject -}}
{{- .Values.sidecar_inject | squote -}}
{{- else -}}
{{- default "false" | squote -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "common.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" $name .Values.image.tag | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Expand the instance of the chart.
*/}}
{{- define "common.instance" -}}
{{- include "common.fullname" . -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "common.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
