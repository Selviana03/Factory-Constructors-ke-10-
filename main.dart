/*
 * TUGAS SESI 10: Factory Constructors
 * Nama  : Serlin Selviana Giay
 * NIM   : 251420030
 * Kelas : SI2A
 * * --- LINK DOKUMENTASI & PROYEK ---
 * Gist Source Code : https://gist.github.com/5c0e154dd50af4a9ac856908061291bc
 * GitHub Pages     : https://selviana03.github.io/Factory-Constructors/
 * * --- MATERI PEMBELAJARAN ---
 * Factory Pattern adalah pola desain untuk mengabstraksi pembuatan objek:
 * 1. Factory Method: Membuat objek tanpa mengekspos logika ke client.
 * 2. Caching: Menghemat memori dengan menggunakan kembali instance yang ada.
 * 3. Pooling: Mengelola sekumpulan objek agar efisien.
 * 4. Subclass Selection: Pemilihan objek dinamis berdasarkan input.
 */

// --- Latihan 1: ConnectionFactory ---
class Connection {
  final String id;
  Connection(this.id);
  void execute(String query) => print("Koneksi $id mengeksekusi: $query");
}

class ConnectionFactory {
  static final List<Connection> _pool = [Connection("DB-1"), Connection("DB-2")];
  static int _index = 0;
  static Connection getConnection() {
    final conn = _pool[_index];
    _index = (_index + 1) % _pool.length;
    return conn;
  }
}

// --- Latihan 2: NotificationFactory ---
abstract class Notification {
  void send(String message);
}
class EmailNotification implements Notification {
  @override
  void send(String msg) => print("Mengirim via Email: $msg");
}
class PushNotification implements Notification {
  @override
  void send(String msg) => print("Mengirim via Push: $msg");
}

class NotificationFactory {
  static Notification create(String platform) {
    if (platform == 'email') return EmailNotification();
    if (platform == 'push') return PushNotification();
    throw Exception("Platform tidak dikenal");
  }
}

// --- Latihan 3: ShapeFactory ---
class Shape {
  final String type;
  Shape(this.type);
}
class ShapeFactory {
  static final Map<String, Shape> _cache = {};
  static Shape getShape(String type) => _cache.putIfAbsent(type, () => Shape(type));
}

// --- Challenge: AnimalFactory ---
abstract class Animal { void speak(); }
class Dog implements Animal { @override void speak() => print("Woof!"); }
class Cat implements Animal { @override void speak() => print("Meow!"); }

class AnimalFactory {
  static final Map<String, Animal> _cache = {};
  static Animal createAnimal(String type) {
    if (type.isEmpty) throw ArgumentError("Tipe tidak boleh kosong");
    return _cache.putIfAbsent(type.toLowerCase(), () {
      switch (type.toLowerCase()) {
        case 'dog': return Dog();
        case 'cat': return Cat();
        default: throw Exception("Hewan tidak dikenal");
      }
    });
  }
}

void main() {
  print("Hasil Tugas Serlin Selviana Giay (251420030)\n");
  ConnectionFactory.getConnection().execute("SELECT * FROM users");
  NotificationFactory.create('email').send('Halo!');
  print("Shape Cache sama: ${identical(ShapeFactory.getShape('lingkaran'), ShapeFactory.getShape('lingkaran'))}");
  AnimalFactory.createAnimal('dog').speak();
}
