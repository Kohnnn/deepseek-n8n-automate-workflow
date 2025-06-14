# N8N Workflow Backup Solution

This solution addresses the issue of n8n workflows being lost after system updates or container restarts, as mentioned in the [n8n community post](https://community.n8n.io/t/lost-all-workflows-credentials-everythig-after-ubuntu-update/22812/7).

## What's Included

1. **Enhanced docker-compose.yml**:
   - Separate volume mounts for different n8n data types
   - Automated n8n backup system with `N8N_PUSH_BACKUP_ENABLED`
   - Recovery mode enabled with `N8N_RECOVERY_MODE`
   - Dedicated database backup container
   - Proper health checks for all services

2. **Backup Scripts**:
   - `backup_n8n_workflows.sh` (Linux/macOS)
   - `backup_n8n_workflows.ps1` (Windows)
   - Both scripts export workflows via the n8n API

3. **Backup Directories**:
   - `backups/n8n_workflows`: Workflow JSON files
   - `backups/n8n_credentials`: Credential data
   - `backups/n8n_binary_data`: Binary data
   - `backups/n8n_settings`: Settings
   - `backups/n8n_backups`: Automated n8n backups
   - `backups/n8n_db_backups`: PostgreSQL database backups

## How to Use

### Running the Stack

```bash
# Start the stack with the enhanced configuration
docker-compose up -d
```

### Setting Up Regular Backups

#### Linux/macOS:
```bash
# Make the script executable
chmod +x backup_n8n_workflows.sh

# Set up a cron job (every 6 hours)
(crontab -l 2>/dev/null; echo "0 */6 * * * $(pwd)/backup_n8n_workflows.sh") | crontab -
```

#### Windows:
1. Edit `backup_n8n_workflows.ps1` to set your n8n API key
2. Open Task Scheduler
3. Create a new task to run the script every 6 hours

### Manual Backup

You can also manually trigger a backup:

```bash
# Linux/macOS
./backup_n8n_workflows.sh

# Windows (PowerShell)
.\backup_n8n_workflows.ps1
```

## Preventing Data Loss

The enhanced configuration helps prevent data loss by:

1. **Multiple Backup Methods**: Both file-based and database backups
2. **Recovery Mode**: n8n's built-in recovery mechanism
3. **Separate Volume Mounts**: Critical data is stored in separate volumes
4. **Automated Backups**: Regular backups without manual intervention
5. **Clear Documentation**: The `backups/n8n_README.md` file contains recovery instructions

## Recovery Process

If workflows are lost despite these measures, see `backups/n8n_README.md` for detailed recovery instructions.

## Important Notes

- Never use `docker-compose down -v` as it will delete volumes
- Always check volume mounts before updating containers
- Consider setting up external backups for critical workflows
- Test the recovery process periodically 