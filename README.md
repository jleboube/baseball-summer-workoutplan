# baseball-summer-workoutplan


# Project Structure
```
workout-calendar/
├── docker-compose.yml
├── docker-compose.ssl.yml
├── Dockerfile
├── nginx-ssl.conf
├── scripts/
│   ├── generate-ssl.sh
│   ├── setup-letsencrypt.sh
│   └── renew-ssl.sh
├── ssl/
│   └── (certificates will be generated here)
├── www/
│   ├── index.html
│   ├── manifest.json
│   └── sw.js
├── backups/
└── README.md
```



# 1. Set up as above, then run:
./scripts/setup-letsencrypt.sh your-domain.com your-email@example.com

# 2. Set up automatic renewal (optional)
# Add to crontab: 0 2 1 * * /path/to/workout-calendar/scripts/renew-ssl.sh
