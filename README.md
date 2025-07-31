# Shartflix Movie App

Shartflix Movie App, kullanıcıların favori filmlerini keşfetmelerine, listelemelerine ve profillerini yönetmelerine olanak tanıyan bir film uygulamasıdır. Uygulama, **Flutter** ile geliştirilmiş olup **Firebase** entegrasyonu ve **MVVM** mimarisi kullanılarak yapılandırılmıştır.

## Özellikler

- **Kullanıcı Girişi ve Kayıt**: Firebase Authentication ile kullanıcı girişi ve kayıt işlemleri.
- **Splash Ekranı**: Uygulama açıldığında kullanıcıyı karşılayan bir splash ekranı.
- **Favori Filmler**: Kullanıcıların favori filmlerini listeleme ve yönetme.
- **Profil Yönetimi**: Kullanıcı profili görüntüleme ve düzenleme.
- **Bottom Navigation Bar**: Ana sayfa, favoriler ve profil arasında kolay gezinme.

## Proje Yapısı

Proje, **MVVM (Model-View-ViewModel)** mimarisi kullanılarak yapılandırılmıştır. Aşağıda proje klasör yapısı ve içerikleri açıklanmıştır:

### `lib/`
- **`main.dart`**: Uygulamanın giriş noktası. Firebase başlatma ve başlangıç rotası burada tanımlanır.
- **`data/`**: Veri katmanını içerir.
  - **`models/`**: Uygulamada kullanılan veri modelleri.
  - **`storage/`**: Yerel veya uzak veri depolama işlemleri.
- **`domain/`**: İş mantığı ve varlık sınıflarını içerir.
- **`presentation/`**: Kullanıcı arayüzü ve ViewModel'leri içerir.
  - **`home/`**: Ana sayfa, giriş ekranı ve ilgili ViewModel'ler.
  - **`splash/`**: Splash ekranı ve ilgili ViewModel.
  - **`profile/`**: Profil ekranı ve ilgili ViewModel.

### `assets/`
- **`SinFlixSplash.png`**: Splash ekranında kullanılan logo veya görsel.

### `android/` ve `ios/`
- Platforma özgü yapılandırma dosyalarını içerir. Firebase entegrasyonu için gerekli ayarlar (`google-services.json`, `Info.plist`) burada yapılır.

### `test/`
- Widget testleri ve birim testler için test dosyalarını içerir.

## Kullanılan Teknolojiler

- **Flutter**: Uygulama geliştirme.
- **Provider**: Durum yönetimi.
- **Dart**: Programlama dili.
- **Gradle**: Android yapılandırma.

## Kurulum

1. **Gereksinimler**:
   - Flutter SDK
   - Android Studio veya VS Code

2. **Projeyi Klonlayın**:
   ```bash
   git clone https://github.com/ahmeth-sd/shartflix_movie_app.git
   cd shartflix_movie_app
   ```

3. **Bağımlılıkları Yükleyin**:
   ```bash
   flutter pub get
   ```


5. **Uygulamayı Çalıştırın**:
   ```bash
   flutter run
   ```

## Ekran Görüntüleri

| Splash Ekranı | Ana Sayfa | Favoriler |
|---------------|-----------|-----------|
| ![Splash](assets/SinFlixSplash.png) | Ana sayfa ekran görüntüsü eklenebilir | Favoriler ekran görüntüsü eklenebilir |


