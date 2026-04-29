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
* Basic CI/CD deployment using GitHub Actions

---

## 🏗️ Project Structure

```id="jz4qz2"
nginx-rotate-app/
│
├── Dockerfile
├── docker-compose.yml
├── start.sh
├── image-release.txt
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

   * Rotates between pages
   * Injects quotes using `fortune`
   * Dynamically updates `index.html`

3. Each page refreshes automatically:

   ```html
   <meta http-equiv="refresh" content="5">
   ```

---

## 🐳 Run Locally

```bash id="3w4kha"
docker-compose up --build
```

Access:

```id="0l5vdg"
http://localhost
```

---

## 💬 Quote Injection

```bash id="0b33mt"
/usr/games/fortune -s
```

Placeholder used in HTML:

```html id="szk6y2"
{{QUOTE}}
```

---

# 🚀 Deployment (Standard CI/CD)

This project uses a **simple production-style deployment**:

* Docker image hosted on Docker Hub
* Version controlled via `image-release.txt`
* Deployment handled by GitHub Actions
* Application runs on EC2 (or any VM)

---

## 📄 image-release.txt

Controls which version is deployed:

```id="b3c9px"
sanjeevtripurari/nginx-rotate-app:v1
```

---

## 🔐 GitHub Secrets (Required)

Go to:

```id="n7y2k8"
Repo → Settings → Secrets → Actions
```

Add the following:

### 1. EC2_HOST

Public IP or DNS of your EC2 instance

```id="6e7y3m"
13.xxx.xxx.xxx
```

---

### 2. EC2_USER

Depends on your instance type:

| OS           | Value    |
| ------------ | -------- |
| Ubuntu       | ubuntu   |
| Amazon Linux | ec2-user |

---

### 3. EC2_SSH_KEY

Paste your private key content:

```id="q1qkpn"
-----BEGIN RSA PRIVATE KEY-----
xxxxx
-----END RSA PRIVATE KEY-----
```

⚠️ Do NOT paste file path

---

## ⚙️ GitHub Actions Workflow

Location:

```id="p9q6oe"
.github/workflows/deploy.yml
```

---

## 🚀 How to Release a New Version

### Step 1 — Build & push Docker image

```bash id="04ow2d"
docker build -t nginx-rotate-app .
docker tag nginx-rotate-app sanjeevtripurari/nginx-rotate-app:v2
docker push sanjeevtripurari/nginx-rotate-app:v2
```

---

### Step 2 — Update release file

```bash id="g5c1pz"
echo "sanjeevtripurari/nginx-rotate-app:v2" > image-release.txt

git add image-release.txt
git commit -m "release v2"
git push
```

---

### ✅ Result

* GitHub Actions triggers automatically
* Connects to EC2
* Pulls latest image
* Restarts container

---

## 🔄 Rollback

```bash id="o8w4y5"
echo "sanjeevtripurari/nginx-rotate-app:v1" > image-release.txt
git commit -am "rollback"
git push
```

---

## ⚠️ Important Notes

### Docker must be installed on EC2

```bash id="p9i4z9"
docker ps
```

---

### Allow Docker without sudo

```bash id="t62e1m"
sudo usermod -aG docker ubuntu
```

---

### Open required ports

AWS Security Group:

```id="f3nrbj"
Port 22 → SSH
Port 80 → HTTP
```

---

### UTF-8 support

```html id="e2o9vh"
<meta charset="UTF-8">
```

---

## 🧪 Debugging

```bash id="yyqfxa"
docker logs nginx-rotate
docker ps
```

---

## 🎯 Key Benefits

* No Git tag complexity
* Simple release mechanism
* Easy rollback
* Fully automated deployment
* Works with any VM

---

## 👤 Author

Sanjeev Tripurari

---

## 📄 License

This project is for learning and demonstration purposes.
