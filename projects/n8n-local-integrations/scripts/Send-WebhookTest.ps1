[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [uri]$WebhookUrl
)

$ErrorActionPreference = 'Stop'
if (-not $WebhookUrl.IsAbsoluteUri -or $WebhookUrl.Scheme -notin @('http', 'https')) {
    throw 'Provide an absolute HTTP or HTTPS webhook URL copied from n8n.'
}

$payload = @{
    name = 'Wagner'
    message = 'External webhook test'
} | ConvertTo-Json

Invoke-RestMethod -Method Post -Uri $WebhookUrl.AbsoluteUri -ContentType 'application/json' -Body $payload -TimeoutSec 30

