# Simple Role Syntax
# ==================
set :stage, :production

# Replace 127.0.0.1 with your server's IP address!
server '178.79.153.246', user: 'deploy', roles: %w{web app}