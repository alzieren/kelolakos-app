# P03 — KelolaKos Mini App

Aplikasi mobile berbasis Flutter yang dirancang untuk membantu pemilik indekos mengelola kamar dan status hunian secara praktis. Aplikasi ini memiliki tiga layar utama: daftar kamar kos, rincian detail kamar, dan formulir pendaftaran kamar baru dengan validasi masukan.

## Fitur & Komponen Utama
1. **Daftar Kamar Interaktif (`RoomListScreen`)**: Menampilkan daftar kamar yang disimpan di memori menggunakan `ListView.builder` serta ringkasan jumlah kamar tersedia secara real-time.
2. **Navigasi Dua Arah**: Navigasi maju-mundur antara Layar Daftar, Layar Detail, dan Layar Tambah Kamar dengan pengembalian data via `Navigator.pop`.
3. **Widget Kustom Reusable (`RoomCard`)**: Kartu kamar yang dirancang modular dan digunakan berulang kali dengan data berbeda (di layar daftar dan di kartu ringkasan layar detail).
4. **Formulir Validasi (`AddRoomScreen`)**: Memiliki tiga tipe masukan berbeda (`TextFormField` teks, `DropdownButtonFormField` tipe kamar, dan `SwitchListTile` status hunian) yang menolak masukan kosong atau angka tidak valid.
5. **Manajemen State**: Menggunakan `StatefulWidget` dengan `setState` yang tepat saat menambah kamar baru maupun memperbarui status hunian.

---

## Catatan Debugging (Bug Mentok & Cara Menemukannya)

- **Gejala Bug**:
  Saat selesai mengisi formulir di Layar Tambah Kamar dan menekan tombol *Simpan*, aplikasi berhasil kembali ke Layar Daftar, namun item kamar baru **tidak muncul** sama sekali di daftar layar utama.
- **Penyebab**:
  Fungsi navigasi `Navigator.push` di Layar Daftar awalnya dipanggil secara sinkron tanpa kata kunci `await`. Akibatnya, baris kode penambahan list dieksekusi secara instan saat layar form baru saja terbuka (ketika nilai kembalian masih bernilai `null`), bukan saat pengguna selesai menekan tombol simpan.
- **Cara Menemukan & Memperbaiki**:
  1. Melakukan pelacakan alur eksekusi menggunakan `debugPrint()` di dalam fungsi navigasi.
  2. Dari log konsol terminal, terlihat bahwa print setelah `Navigator.push` langsung tercetak mendahului penekanan tombol simpan pada form.
  3. Masalah diselesaikan dengan mengubah metode navigasi menjadi `async`, menambahkan `await Navigator.push<Room>(...)`, serta membungkus penambahan data ke dalam `setState(() { _rooms.add(newRoom); })` hanya apabila objek `newRoom != null`.

---

## Tautan Video Demonstrasi (3 Menit)
- **Tautan YouTube (Unlisted)**: `[Masukkan link video YouTube Anda di sini]`

## Cara Menjalankan Proyek
```bash
# 1. Masuk ke direktori proyek
cd p03_kelolakos

# 2. Periksa kesiapan linter (harus bersih tanpa error)
flutter analyze

# 3. Jalankan di emulator / perangkat
flutter run
```
