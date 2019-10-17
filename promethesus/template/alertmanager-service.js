[Unit]
Description={{serviceName}}
Wants=network-online.target
After=network-online.target

[Service]
User={{ userId }}
Group={{ groupId }}
Restart=always
RestartSec=2
StartLimitInterval=0
Type=simple
ExecStart={{ exec_command }}

[Install]
WantedBy=multi-user.target