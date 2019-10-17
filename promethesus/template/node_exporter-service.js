[Unit]
Description=Node Exporter
#After=network.target
Wants=network-online.target
After=network-online.target


[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/{{ service_name }}

[Install]
WantedBy=multi-user.target