# PowerShell script to automatically export n8n workflows as JSON files
# To use: 
# 1. Set Execution Policy: Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
# 2. Schedule task: Create a Windows Task Scheduler task to run this script

# Configuration
$BackupDir = ".\backups\n8n_workflows"
$N8nApiUrl = "http://localhost:5678/api/v1"
$N8nApiKey = "YOUR_N8N_API_KEY" # Replace with your actual API key
$MaxBackups = 30 # Keep last 30 backups
$Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"

# Create backup directory if it doesn't exist
if (-not (Test-Path -Path $BackupDir)) {
    New-Item -ItemType Directory -Path $BackupDir -Force | Out-Null
}

if (-not (Test-Path -Path "$BackupDir\archive")) {
    New-Item -ItemType Directory -Path "$BackupDir\archive" -Force | Out-Null
}

# Create a timestamped directory for this backup
$BackupTimestampDir = "$BackupDir\archive\backup_$Timestamp"
New-Item -ItemType Directory -Path $BackupTimestampDir -Force | Out-Null

# Export all workflows
Write-Host "Exporting workflows at $(Get-Date)"
$Headers = @{
    "X-N8N-API-KEY" = $N8nApiKey
    "Accept" = "application/json"
}

try {
    $Workflows = Invoke-RestMethod -Uri "$N8nApiUrl/workflows" -Headers $Headers -Method Get
    
    foreach ($Workflow in $Workflows.data) {
        $Id = $Workflow.id
        # Replace special characters with underscore
        $Name = $Workflow.name -replace '[^a-zA-Z0-9]', '_'
        Write-Host "Exporting workflow: $Name (ID: $Id)"
        
        # Save to timestamp directory
        $Workflow | ConvertTo-Json -Depth 100 | Out-File -FilePath "$BackupTimestampDir\${Name}_${Id}.json" -Encoding UTF8
        
        # Also save to main directory (overwrite existing)
        $Workflow | ConvertTo-Json -Depth 100 | Out-File -FilePath "$BackupDir\${Name}_${Id}.json" -Encoding UTF8
    }

    # Create a full backup archive
    Compress-Archive -Path "$BackupDir\*.json" -DestinationPath "$BackupDir\workflow_backup_$Timestamp.zip" -Force
    
    # Clean up old backups (keep only the most recent MaxBackups)
    Get-ChildItem -Path $BackupDir -Filter "workflow_backup_*.zip" | 
        Sort-Object -Property LastWriteTime -Descending | 
        Select-Object -Skip $MaxBackups | 
        Remove-Item -Force
    
    # Keep only the most recent 10 timestamped directories
    Get-ChildItem -Path "$BackupDir\archive" -Directory -Filter "backup_*" | 
        Sort-Object -Property LastWriteTime -Descending | 
        Select-Object -Skip 10 | 
        Remove-Item -Recurse -Force
    
    Write-Host "Backup completed at $(Get-Date)"
} catch {
    Write-Error "Error exporting workflows: $_"
} 