## 📦 MeshSerbia Auto-Deploy Script

Ovaj projekat sadrži **Bash skriptu** koja automatski preuzima najnoviju verziju MeshSerbia sajta, kompajlira ga, čisti direktorijum od nepotrebnih fajlova i priprema sve za pokretanje putem Docker kontejnera.

### 🛠️ Karakteristike
- Testirano na Debian
- Pisano u Bash-u
- Nema zavisnosti osim `git`, `docker`

### 🚀 Pokretanje

```bash
./update-deploy.sh
```

```bash
docker run -d --name meshserbia-nginx -p 8095:80 meshserbia-nginx
```

### 📁 Struktura
- `update-deploy.sh` – glavna skripta za preuzimanje i pripremu sajta
- `nginx.conf` – opcioni Nginx config fajl (ako koristiš custom podešavanja), trenutno koristi default nginx config
- `Dockerfile` – pravi lightweight Nginx image sa prekopiranim buildom

### 🧹 Automatsko čišćenje uključuje:
meshserbia-website direktorijum, ne dira nista vise.
