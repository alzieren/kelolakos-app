# P03 — KelolaKos

Aplikasi Flutter sederhana untuk pencatatan dan pengelolaan kamar kos. Aplikasi ini dibuat untuk tugas praktikum P03, dengan fungsi utama untuk melihat daftar kamar kos, melihat rincian tiap kamar, mengubah status kamar (tersedia / terisi), dan menambahkan data kamar baru.

- **Repository**: https://github.com/alzieren/kelolakos-app

## Halaman dan Fitur

1. **Daftar Kamar (`RoomListScreen`)**
   - Menampilkan daftar kamar kos beserta ringkasan status di bagian atas (total kamar, jumlah kamar yang tersedia, dan jumlah kamar yang terisi).
   - Fitur pencarian kamar berdasarkan nomor kamar, tipe kamar, atau fasilitas.
   - Tombol filter cepat untuk menampilkan kamar berdasarkan statusnya (Semua, Tersedia, Terisi).
   - Pesan keterangan jika kamar yang dicari tidak ditemukan.

2. **Detail Kamar (`RoomDetailScreen`)**
   - Menampilkan rincian lengkap kamar yang dipilih, seperti nomor kamar, tipe, ID sistem, harga sewa per bulan, dan status hunian saat ini.
   - Menampilkan daftar fasilitas kamar dalam bentuk tag berikon.
   - Tombol untuk langsung mengubah status kamar (dari Tersedia menjadi Terisi, atau sebaliknya).

3. **Tambah Kamar (`AddRoomScreen`)**
   - Form input untuk nomor kamar, harga sewa per bulan, dan fasilitas.
   - Pilihan tipe kamar (Standard, Deluxe, VIP).
   - Tombol cepat untuk menambahkan fasilitas umum (seperti AC, WiFi, Kamar Mandi Dalam, Kasur Queen, dll.) agar tidak perlu mengetik manual satu per satu.
   - Switch untuk menentukan status awal kamar (sudah terisi atau masih kosong).
   - Validasi form agar input tidak kosong dan nominal harga berupa angka valid.

4. **Widget Kartu Kamar (`RoomCard`)**
   - Widget terpisah yang reusable untuk menampilkan ringkasan data kamar secara rapi dan konsisten.

## Catatan Debugging

- **Kendala / Bug**:
  Saat pertama kali mencoba form tambah kamar dan klik tombol Simpan, aplikasi berhasil kembali ke halaman utama tetapi data kamar yang baru diisi tidak muncul di daftar.
- **Penyebab**:
  Navigasi `Navigator.push` di halaman utama belum diberi kata kunci `await`. Akibatnya, baris penambahan data ke list langsung dijalankan sebelum user selesai mengisi dan menyimpan form (saat data kembaliannya masih `null`).
- **Solusi**:
  Fungsi navigasi diubah menjadi `async`, ditambahkan `await` pada pemanggilan `Navigator.push<Room>(...)`, dan penambahan item ke list dibungkus dalam `setState(() { _rooms.add(newRoom); })` dengan pengecekan `if (newRoom != null)`.

## Cara Menjalankan

```bash
# 1. Clone repository & masuk ke folder
git clone https://github.com/alzieren/kelolakos-app.git
cd kelolakos-app

# 2. Unduh dependensi
flutter pub get

# 3. Jalankan aplikasi
flutter run
```

