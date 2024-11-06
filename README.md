# pec_mobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# TUGAS 7

## Jelaskan apa yang dimaksud dengan stateless widget dan stateful widget, dan jelaskan perbedaan dari keduanya.

Stateless Widget adalah widget yang tidak memiliki kondisi atau state yang bisa berubah-ubah, yang mana berarti tampilannya bakal statis Contohnya, icon yang tidak akan berubah-ubah tampilannya. Sedangkan, Stateful Widget memiliki karakteristik kebalikan dari Stateless Widget, yaitu
dia memiliki state yan bisa berubah saat aplikasi berjalan sehingga tampilannya dapat diperbaharui berdasarkan perubahaan yang ada. Contohnya, jika kita menggunakan widget Checkbox, maka kondisinya dapat berubah sesuai dengan statusnya.

## Sebutkan widget apa saja yang kamu gunakan pada proyek ini dan jelaskan fungsinya
1. Scaffold: Untuk menyediakan struktur dasar halaman, seperti AppBar
2. AppBar: Berfungsi sebagai header/judul aplikasi.
3. Padding: Untuk Memberikan jarak di sekitar body atau widget tertentu agar tidak langsung menyentuh pinggiran layar
5. Column (top-to-bottom): untuk menyusun widget secara vertical
6. Row (left-to-right): untuk menyusun widget secara horizontal
7. SnackBar: Untuk menampilkan informasi seperti notifikasi dibagian bawah pada layar
8. Inkwell: Untuk menambahkan efek animasi pada elemen
9. Card: Untuk menyediakan kontainer agar kita dapat menampilkannya seacra terstruktur
10. Icon: Untuk menampilkan icon pada layar
11. GridView: untuk menampilkan item dalam grid tertentu

##  Apa fungsi dari setState()? Jelaskan variabel apa saja yang dapat terdampak dengan fungsi tersebut.

Fungsi setState() digunakan dalam Stateful Widget untuk memperbarui UI berdasarkan perubahan pada state internal widget. Contohnya, jika variabel yang menyimpan jumlah klik sebuah tombol berubah, maka setState() memastikan UI menampilkan jumlah klik yang terbaru. Semua variabel yang berada dalam state dari widget itu akan terdampak dan di-render ulang dengan data terbaru setelah setState() dipanggil.

##  Jelaskan perbedaan antara const dengan final.

Const dan final dapat digunakan untuk membuat variabel immutable, tetapi memiliki karakteristik yang cukup berbeda. Dimana const dapat mendeklarasikan variabel yang nilainya bersifat konstan dan wajib diketahui saat kita ingin mengcompile, sedangkan final memungkinkan kita dapat menginisialisasi nilai pada runtime (tidak harus saat sebelum ingin mengcompile programnya ). Jadi, const lebih ketat karena memerlukan nilai yang pasti, sementara final lebih fleksibel untuk nilai yang dapat diketahui hanya pada runtime.

## Implementasi Tugas 7

1. Generate proyeknya terlebih dahulu dengan command dibawah ini dengan appname pec_mobile
```
flutter create <APP_NAME>
cd <APP_NAME>
```

2. Pada direktori lib, kita dapat membuat file baru yaitu menu.dart yang akan berisi halaman utama kita nantinya. Lalu, kita pun perlu menyiapkan class item untuk menampung item di homepage kita nantinya.

```dart
class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color; // Agar suatu item dapat memilih warnanya tersendiri

  ItemHomepage(this.name, this.icon, this.color);
 }
```
Disini kita perlu menambahkan parameter baru pada konstruktor agar nanti suatu item tersebut dapat memiliki warnanya tersendiri jika diperlukan.

3. Setelah itu, kita dapat membuat item card yang akan ditampilkan pada homepage kita dengan fitur snackbar

```dart
class ItemCard extends StatelessWidget {
  // Menampilkan kartu dengan ikon dan nama.

  final ItemHomepage item; 
  
  const ItemCard(this.item, {super.key}); 

  @override
  Widget build(BuildContext context) {
    return Material(
      // Menentukan warna latar belakang dari tema aplikasi.
      color: item.color,
      // Membuat sudut kartu melengkung.
      borderRadius: BorderRadius.circular(12),
      
      child: InkWell(
        // Aksi ketika kartu ditekan.
        onTap: () {
          // Menampilkan pesan SnackBar saat kartu ditekan.
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("Kamu telah menekan tombol ${item.name}"))
            );
        },
        // Container untuk menyimpan Icon dan Text
        ... // Dapat dilihat pada file di libnya
      ),
    );
  }
}
```
Pada class item card ini, kita memerlukan class homepage untuk di passing ke konstruktor item card dan pada widget kita bisa menyesuaikan warna dengan cara "memanggil" attribut dari class ItemHomepage. 

```dart
color: item.color,
```

Dan jangan lupa menambahkan SnackBar agar suatu item jika ditekan nanti akan muncul informasi bahwa tombol tersebut sudah diclick.

4. Terakhir pada kelas MyHomePage, kita perlu menambahkan item-item yang akan ditampilkan nantinya. Seperti tombol Lihat Daftar Produk, Tambah Produk, dan logout.

```dart
final List<ItemHomepage> items = [
         ItemHomepage("Lihat Daftar Produk", Icons.smartphone, const Color.fromARGB(255, 99, 199, 103)),
         ItemHomepage("Tambah Produk", Icons.add_box, Colors.blue),
         ItemHomepage("Logout", Icons.logout, Colors.red),
     ];
```

Dari sini terlihat bahwa item kita akan memiliki warna yang berbeda-beda disebabkan kita menambahkan parameter baru pada class ItemHomepage.
Setelah ditambahkan, kita perlu mengiterasinya agar dapat ditampilkan di homepage nantinya.

```dart
    // Grid untuk menampilkan ItemCard dalam bentuk grid 3 kolom.
    GridView.count(
    primary: true,
    padding: const EdgeInsets.all(20),
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    crossAxisCount: 3,
    // Agar grid menyesuaikan tinggi kontennya.
    shrinkWrap: true,

    // Menampilkan ItemCard untuk setiap item dalam list items.
    children: items.map((ItemHomepage item) {
        return ItemCard(item);
    }).toList(),
    ),
```

Dan tara~ kita berhasil menambahkan tombol-tombol tersebut dengan warna yang berbeda.