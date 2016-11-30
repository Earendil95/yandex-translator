# Change to match your CPU core count
workers 1

# Min and Max threads per worker
threads 1, 4

app_dir = File.expand_path("../..", __FILE__)
shared_dir = "#{app_dir}/shared"

environment "production"

# Set up socket location
bind "ssl://0.0.0.0:443?key=rootCA.key&cert=rootCA.crt"

# Logging
stdout_redirect "#{shared_dir}/log/puma.stdout.log", "#{shared_dir}/log/puma.stderr.log", true

# Set master PID and state locations
pidfile "#{shared_dir}/pids/puma.pid"
state_path "#{shared_dir}/pids/puma.state"
activate_control_app
