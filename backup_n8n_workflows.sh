#!/bin/bash
# Script to automatically export n8n workflows as JSON files
# To use: 
# 1. Make executable: chmod +x backup_n8n_workflows.sh
# 2. Set up a cron job: crontab -e
#    0 */6 * * * /path/to/backup_n8n_workflows.sh

# Configuration
BACKUP_DIR="./backups/n8n_workflows"
N8N_API_URL="http://localhost:5678/api/v1"
N8N_API_KEY="YOUR_N8N_API_KEY" # Replace with your actual API key
MAX_BACKUPS=30 # Keep last 30 backups
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"
mkdir -p "$BACKUP_DIR/archive"

# Create a timestamped directory for this backup
BACKUP_TIMESTAMP_DIR="$BACKUP_DIR/archive/backup_$TIMESTAMP"
mkdir -p "$BACKUP_TIMESTAMP_DIR"

# Export all workflows
echo "Exporting workflows at $(date)"
curl -s "$N8N_API_URL/workflows" \
  -H "X-N8N-API-KEY: $N8N_API_KEY" \
  -H "Accept: application/json" \
  | jq -c '.data[]' \
  | while read -r workflow; do
      id=$(echo "$workflow" | jq -r '.id')
      name=$(echo "$workflow" | jq -r '.name' | sed 's/[^a-zA-Z0-9]/_/g')
      echo "Exporting workflow: $name (ID: $id)"
      
      # Save to timestamp directory
      echo "$workflow" | jq '.' > "$BACKUP_TIMESTAMP_DIR/${name}_${id}.json"
      
      # Also save to main directory (overwrite existing)
      echo "$workflow" | jq '.' > "$BACKUP_DIR/${name}_${id}.json"
    done

# Create a full backup archive
tar -czf "$BACKUP_DIR/workflow_backup_$TIMESTAMP.tar.gz" -C "$BACKUP_DIR" .

# Clean up old backups (keep only the most recent MAX_BACKUPS)
cd "$BACKUP_DIR"
ls -t workflow_backup_*.tar.gz | tail -n +$((MAX_BACKUPS+1)) | xargs -r rm

# Keep only the most recent 10 timestamped directories
cd "$BACKUP_DIR/archive"
ls -td backup_* | tail -n +11 | xargs -r rm -rf

echo "Backup completed at $(date)" 