# Baseball Workout Calendar

Workout Schedule for a Father and his Son

A containerized workout tracking application for baseball training.

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

## Quick Start

1. Clone this repository
2. Run ``` ./scripts/setup-letsencrypt.sh your-domain.com your-email@example.com ```
3. Set up automatic renewal (optional) - Add to crontab:``` 0 2 1 * * /path/to/workout-calendar/scripts/renew-ssl.sh ```
4. Run: `docker compose up -d`
5. Visit: https://localhost:8080
6. Start tracking your workouts!

## Features

- ⚾ Baseball-specific workout plans
- 📊 Weekly progress tracking
- 📱 Mobile-optimized PWA
- 🔧 Admin panel for customization
- 📈 Historical progress view
- 🐳 Docker containerized

## Commands

- `docker compose up -d` - Start the application
- `docker compose down` - Stop the application
- `docker compose logs -f` - View logs
- `docker compose restart` - Restart the application

## Accessing Your App

- Local: http://localhost:8080
- Network: http://YOUR_IP:8080
- Mobile: Add to home screen for app-like experience

## Data Storage

All workout data is stored locally in your browser's IndexedDB. Use the export feature in the admin panel to backup your data.




