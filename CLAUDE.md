# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Rails 8.0.2 application using Ruby 3.4.5, designed as a social app with modern Rails architecture. The app uses PostgreSQL as the primary database and is configured for containerized deployment using Docker and Kamal.

## Technology Stack

- **Framework**: Rails 8.0.2 (Ruby 3.4.5)
- **Database**: PostgreSQL with separate databases for cache, queue, and cable in production
- **Frontend**: Hotwire (Turbo + Stimulus), Import maps for JavaScript
- **Asset Pipeline**: Propshaft
- **Background Jobs**: Solid Queue
- **Caching**: Solid Cache
- **WebSockets**: Solid Cable
- **Deployment**: Docker + Kamal
- **Web Server**: Puma (development), Thruster + Puma (production)

## Development Commands

### Setup and Installation
```bash
# Initial setup (installs dependencies, prepares database, starts server)
bin/setup

# Install dependencies only (skip server startup)
bin/setup --skip-server
```

### Running the Application
```bash
# Start development server
bin/dev

# Start Rails server directly
bin/rails server
```

### Database Operations
```bash
# Prepare database (create, migrate, seed if needed)
bin/rails db:prepare

# Create and migrate database
bin/rails db:create db:migrate

# Seed database
bin/rails db:seed

# Database console
bin/rails dbconsole
```

### Testing
```bash
# Run all tests
bin/rails test

# Run system tests
bin/rails test:system

# Run specific test file
bin/rails test test/path/to/test_file.rb
```

### Code Quality
```bash
# Run RuboCop linter
bin/rubocop

# Auto-fix RuboCop issues
bin/rubocop -a

# Security analysis
bin/brakeman
```

### Asset Management
```bash
# Manage JavaScript imports
bin/importmap

# Precompile assets
bin/rails assets:precompile
```

### Background Jobs
```bash
# Start job worker
bin/jobs
```

### Deployment
```bash
# Deploy with Kamal
bin/kamal deploy

# Kamal commands
bin/kamal setup    # Initial server setup
bin/kamal app boot # Start the app
bin/kamal logs     # View logs
```

## Architecture

### Database Configuration
The application uses a multi-database setup in production:
- **Primary**: Main application data (`social_app_production`)
- **Cache**: Rails cache storage (`social_app_production_cache`)
- **Queue**: Background job storage (`social_app_production_queue`)
- **Cable**: WebSocket connection storage (`social_app_production_cable`)

### Frontend Architecture
- **Hotwire Stack**: Uses Turbo for SPA-like navigation and Stimulus for JavaScript behavior
- **Import Maps**: JavaScript dependencies managed without bundling
- **Propshaft**: Modern asset pipeline for CSS and static assets
- **Stimulus Controllers**: Located in `app/javascript/controllers/`

### Application Structure
- Standard Rails MVC pattern with conventional directory structure
- Application name: `SocialApp` (module in `config/application.rb`)
- Base classes: `ApplicationController`, `ApplicationRecord`, `ApplicationJob`, `ApplicationMailer`
- PWA support configured but commented out in routes

### Code Style
- Uses `rubocop-rails-omakase` for Ruby styling
- Configuration in `.rubocop.yml` inherits from the omakase gem

### Docker & Production
- Multi-stage Dockerfile optimized for production
- Uses Thruster as reverse proxy in production
- Kamal for zero-downtime deployments
- Non-root user (rails:1000) for security