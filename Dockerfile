# 1. Menggunakan Node.js v24 berbasis Alpine Linux yang super ringan dan aman
FROM node:24-alpine

# 2. Menentukan direktori kerja di dalam container
WORKDIR /usr/src/app

# 3. Menyalin file package.json dan package-lock.json untuk instalasi dependencies
COPY package*.json ./

# 4. Menginstal hanya dependencies yang diperlukan untuk production
RUN npm ci --only=production

# 5. Menyalin seluruh source code aplikasi ke dalam container
COPY . .

# 6. Membuka port 3000 agar bisa diakses dari luar container
EXPOSE 8080

# 7. Perintah utama untuk menjalankan aplikasi
CMD [ "node", "app.js" ]