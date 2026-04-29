# NGINX Rotating Quote App (Docker + Fortune)

## 📌 Overview

This project demonstrates a simple yet effective **Docker-based NGINX application** that:

* Serves static HTML pages
* Rotates between multiple pages automatically
* Displays dynamic quotes using the Linux `fortune` utility
* Refreshes content every few seconds

It is a great hands-on project to understand:

* Docker image creation
* NGINX static hosting
* Shell scripting automation
* Dynamic content injection in static pages

---

## 🏗️ Project Structure

```
nginx-rotate-app/
│
├── Dockerfile
├── docker-compose.yml
├── start.sh
│
└── webpages/
    ├── index1.html
    ├── index2.html
    ├── index3.html
    └── rotate_pages.sh
```

---

## ⚙️ How It Works

1. NGINX serves files from:

   ```
   /usr/share/nginx/html
   ```

2. A background script (`rotate_pages.sh`) runs inside the container:

   * Selects one HTML page at a time
   * Injects a quote using `fortune`
   * Updates `index.html` dynamically

3. NGINX always serves:

   ```
   index.html
   ```

4. Each HTML page refreshes automatically every 5 seconds:

   ```html
   <meta http-equiv="refresh" content="5">
   ```

---

## 🐳 Docker Setup

### Dockerfile

* Uses `nginx:latest`
* Installs:

  * `fortune`
  * `fortunes`
* Copies HTML pages and scripts
* Starts NGINX + rotation script

---

## ▶️ Run the Application

### 1. Build and start container

```bash
docker-compose up --build
```

### 2. Access in browser

```
http://localhost
```

---

## 🔁 Page Rotation Logic

The script:

```bash
webpages/rotate_pages.sh
```

* Cycles through:

  * `index1.html`
  * `index2.html`
  * `index3.html`
* Injects a new quote every cycle
* Runs for a defined duration

---

## 💬 Quote Injection

Quotes are generated using:

```bash
/usr/games/fortune -s
```

They are inserted into HTML using:

```html
{{QUOTE}}
```

The script replaces this placeholder dynamically.

---

## ⚠️ Important Notes

### 1. Fortune Path

On Debian-based images:

```
/usr/games/fortune
```

Ensure your script uses the full path.

---

### 2. UTF-8 Support

Make sure each HTML file includes:

```html
<meta charset="UTF-8">
```

---

### 3. Safe Quote Handling

The project uses `awk` to safely inject quotes without breaking HTML.

---

## 🧪 Debugging Tips

### Check container logs

```bash
docker logs nginx-rotate
```

### Access container shell

```bash
docker exec -it nginx-rotate bash
```

### Test fortune manually

```bash
/usr/games/fortune
```

## 👤 Author

Sanjeev Tripurari

---

## 📄 License

This project is for learning and demonstration purposes.