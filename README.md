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

# TUGAS 8

## Apa kegunaan const di Flutter? Jelaskan apa keuntungan ketika menggunakan const pada kode Flutter. Kapan sebaiknya kita menggunakan const, dan kapan sebaiknya tidak digunakan?

const digunakan untuk membuat widget yang bersifat immutable atau tidak berubah selama aplikasi berjalan. Hal ini dapat berguna untuk menghemat memori karena hanya akan membuat satu instance saja dan dapat digunakan secara berulah, yang mana akan mempercepat proses rendering. Sebaiknya kita menggunakan const saat kita menggunakan widget statis dan kalau bisa menghindari saat penggunaan widget dinamis.

##  Jelaskan dan bandingkan penggunaan Column dan Row pada Flutter. Berikan contoh implementasi dari masing-masing layout widget ini!

Column dan Row adalah widget tata letak di Flutter untuk menyusun widget secara vertikal dan horizontal. Column digunakan untuk menempatkan elemen dari atas ke bawah, sedangkan Row dari kiri ke kanan.

contoh Column:
```dart
Column(
  children: [
    Text('Item 1'), 
    Text('Item 2')],
);
```
contoh Row:
```dart
Row(
  children: [Icon(Icons.mood), Text('mood')],
);
```

## Sebutkan apa saja elemen input yang kamu gunakan pada halaman form yang kamu buat pada tugas kali ini. Apakah terdapat elemen input Flutter lain yang tidak kamu gunakan pada tugas ini? Jelaskan!

Pada halaman form aplikasi ini, elemen input yang digunakan adalah TextFormField untuk menerima teks atau angka dari user. 
Lalu pada aplikasi ini, saya tidak menambahkan elemen input lain seperti Checkbox, RadioButton, dan Slider karena tidak dibutuhkan dalam form produk ( untuk saat ini ).

## Bagaimana cara kamu mengatur tema (theme) dalam aplikasi Flutter agar aplikasi yang dibuat konsisten? Apakah kamu mengimplementasikan tema pada aplikasi yang kamu buat?

Tema pada aplikasi ini diatur dengan MaterialApp sehingga kita dapat menjaga konsistensi temanya. Contohnya pada tugas ini, saya menggunakan warna tema utama dengan warna hijau pada main.dart.
```dart
primarySwatch: Colors.green,
```
Sehingga kita dapat menggunakan hal ini untuk menjaga konsistensi pada halaman di aplikasi kita agar sesuai tema utama.

## Bagaimana cara kamu menangani navigasi dalam aplikasi dengan banyak halaman pada Flutter?

Pada aplikasi ini saya menggunakan navigator dengan metode push dan pushReplacement untuk berpindah halaman. Contohnya di tombol Tambah Produk, saya menggunakan push agar kita menyimpan routing diatas stack sehingga kita dapat back ke halaman sebelumnya dan juga menggunakan pushReplacement pada drawer agar kita dapat mengganti stack paling atas ( bukan ditumpuk ) dengan halaman tujuan kita.


# TUGAS 9

## Jelaskan mengapa kita perlu membuat model untuk melakukan pengambilan ataupun pengiriman data JSON? Apakah akan terjadi error jika kita tidak membuat model terlebih dahulu?

Kita perlu membuat model untuk mempermudah dalam pengelolahan data JSON agar lebih terorganisir dalam bentuk objek. Sehingga kita dapat memetakan data JSON ke atribut-atribut dalam aplikasi kita. Jika tidak membuat model maka perlu turun tangan secara langsung dalam menangani data JSON mentah, yang mana akan berpotensi error karena syntax atau pun kesalahan lainnnya.

## Jelaskan fungsi dari library http yang sudah kamu implementasikan pada tugas ini

Library http digunakan untuk mengirimkan request HTTP, seperti GET, POST, PUT, atau DELETE, ke web service. Dalam tugas ini, library ini memungkinkan aplikasi Flutter untuk berkomunikasi dengan server Django melalui protokol HTTP. Contohnya http.get() digunakan untuk mengambil data, sedangkan http.post() digunakan untuk mengirim data ke server.


## Jelaskan fungsi dari CookieRequest dan jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.

CookieRequest merupakan bagian dari package pbp_django_auth yang digunakan untuk mengelola session dan autentikasi berbasis cookie antara Flutter dan Django. Dengan CookieRequest ini, aplikasi kita dapat menyimpan informasi login user dan mengirimkan cookie tersebut dalam setiap permintaan HTTP untuk menjaga autentikasinya. Instance ini perlu dibagikan ke semua komponen aplikasi melalui provider agar komponen lain bisa menggunakan session yang sama tanpa harus membuat instance baru.

## Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.

Pengiriman data dimulai dari input yang diberikan user melalui form di Flutter kita. Data ini kemudian dikonversi ke format JSON menggunakan metode seperti toJson() sebelum dikirim ke API menggunakan request HTTP (misalnya POST). Setelah itu, server Django menerima JSON tersebut dan memprosesnya (misalnya menyimpannya ke database), dan mengembalikan kembali respons JSON nya. Respons ini kemudian dikonversi kembali ke model Flutter menggunakan fromJson() dan siap ditampilkan.

## Jelaskan mekanisme autentikasi dari login, register, hingga logout. Mulai dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.

Pada proses login dan register, user akan mengisi form di Flutter dan data ini dikirim ke endpoint django menggunakan metode POST. Django memproses data ini (misalnya mencocokkan password atau membuat akun baru), lalu mengembalikan status autentikasi dalam respons JSON. Jika login berhasil, cookie disimpan oleh CookieRequest untuk menjaga sesi user. Saat logout, CookieRequest mengirimkan permintaan logout ke django dan sesi dihapus. Setelah autentikasi selesai, aplikasi Flutter menavigasikannya ke halaman menu utama kita.

## Implementasi TUGAS 9

1. Menambahkan aplikasi baru pada proyek django kita, yaitu authentication. Dan jangan lupa menambahkan urls dan mengubah setting proyek kita agar authentication dapat berjalan dengan lancar. Setelah itu, barulah kita mengurusi views dan routing dari aplikasi authentication yang sudah dibuat.

2. Setelah itu kita perlu mengitegrasikan sistem authentikasi pada Flutter kita. Hal ini bisa dilakukan dengan menginstall package yang diperlukan terlebih dahulu,

```
flutter pub add provider
flutter pub add pbp_django_auth
```

Lalu mengubah root widget agar dapat menyediakan CookieRequestnya

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'PEC',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.green,
          ).copyWith(secondary: Colors.greenAccent[400]),
        ),
        home: const LoginPage(),
      ),
    );
  }
}
```

3. Barulah kita mengimplementasikan halaman login dan register, pada bagian ini code dapat dilihat pada file login.dart ( karena lumayan panjang ). Dan saat sudah menambahkan file tersebut, kita perlu mengubah bagian home: MyHomePage() -> menjadi home: const LoginPage(), di main.dart. ( seperti yang diatas ini ). Setelah itu kita perlu menambahkan fungsi register pada views.py di aplikasi authentication kita.

```python
from django.contrib.auth.models import User
import json

@csrf_exempt
def register(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        username = data['username']
        password1 = data['password1']
        password2 = data['password2']

        # Check if the passwords match
        if password1 != password2:
            return JsonResponse({
                "status": False,
                "message": "Passwords do not match."
            }, status=400)
        
        # Check if the username is already taken
        if User.objects.filter(username=username).exists():
            return JsonResponse({
                "status": False,
                "message": "Username already exists."
            }, status=400)
        
        # Create the new user
        user = User.objects.create_user(username=username, password=password1)
        user.save()
        
        return JsonResponse({
            "username": user.username,
            "status": 'success',
            "message": "User created successfully!"
        }, status=200)
    
    else:
        return JsonResponse({
            "status": False,
            "message": "Invalid request method."
        }, status=400)
```
Dan lakukan routing pada fungsi tersebut dan menambahkan file register.dart ( dapat dilihat pada filenya langsung )

4. Langkah selanjutnya, kita perlu membuat model kustom yang sesuai dengan model proyek django kita. Hal ini dilakukan dengan mengambil data JSON pada proyek django, lalu menggunakan tools dari https://app.quicktype.io/, kita dapat mengambil code untuk penanganan model nantinya dan menambahkannya pada lib/models/product.dart

```dart
// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
    String model;
    String pk;
    Fields fields;

    Product({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int user;
    String name;
    int price;
    String description;

    Fields({
        required this.user,
        required this.name,
        required this.price,
        required this.description,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "name": name,
        "price": price,
        "description": description,
    };
}

```
5. Setelah ada modelnya kita dapat membuat halaman yang menampilkan item-item kita. Hal ini dapat dilihat pada direktori lib/screens/list_product.dart dan menghubungkannya dengan file baru untuk menampilkan detail dari product-product tersebut di lib/screens/details_product.dart

6. Untuk mengenai masalah Filtering product yang hanya terkait user tersebut. Kita dapat menggunakan cookie dari autentikasi untuk memastikan hanya data milik user login yang diambil dari server Django. Sehingga data nantinya sudah terfilter.


Dan tara~~ proyek django dan flutter kita sudah terimplementasi dan terintegrasi
