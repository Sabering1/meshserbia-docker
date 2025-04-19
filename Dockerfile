# Koristi zvaničnu Nginx sliku
FROM nginx:latest

# Kopiraj tvoje Hugo generisane fajlove u Nginx root folder
COPY ./public /usr/share/nginx/html

# Kopiraj tvoju Nginx konfiguraciju
#COPY ./nginx.conf /etc/nginx/nginx.conf

# Otvori port 80 (HTTP)
EXPOSE 80

# Nginx će automatski startovati kada se container pokrene
CMD ["nginx", "-g", "daemon off;"]
