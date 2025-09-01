FROM laravelsail/php82-composer:latest

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# # Set working directory
# WORKDIR /var/www

# # Copy composer files first (for better caching)
# COPY composer.json composer.lock ./

# # Install dependencies (without dev if it's production)
# RUN composer install

# # Now copy the rest of the application
# COPY . .
