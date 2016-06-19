#!/bin/bash
/usr/bin/supervisord
bash /opt/tools/setup_frappe.sh --setup-production
