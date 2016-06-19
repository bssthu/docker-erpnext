# docker-erpnext
run erpnext server


## Setup

### download
```bash
docker pull bssthu/erpnext:latest
```

### create container
```bash
docker create -v /home/frappe/frappe-bench/sites/site1.local/ -v /var/lib/mysql --name erpdata bssthu/erpnext
```

### run erpnext
```bash
docker run -d -p 80:80 --name erpnext --volumes-from erpdata bssthu/erpnext
```

### stop/remove erpnext
```bash
docker stop erpnext
docker rm erpnext
```

### get passwords
```bash
docker exec erpnext  cat /root/frappe_passwords.txt
```
**Warning**:
Images from bssthu/erpnext at Dockerhub use the same passwords.
Change passwords immediately.


## Credits
- https://github.com/pfy/erpnext


## License
LGPLv3