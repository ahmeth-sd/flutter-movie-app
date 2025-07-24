lib/
├── data/                      # MODEL Katmanı (veri erişim)
│     ├── models/              # DTO'lar
│     │     └── movie_model.dart
│     └── repositories/
│           └── movie_repository.dart
│
├── domain/                    # DOMAIN Katmanı (iş kuralları)
│     ├── entities/
│     │     └── movie.dart
│     └── usecases/
│           └── get_movies_usecase.dart
│
└── presentation/              # VIEW + VIEWMODEL Katmanı
├── home/
│     ├── view/
│     │     └── home_page.dart
│     ├── viewmodel/
│     │     ├── home_cubit.dart
│     │     └── home_state.dart
│     └── widgets/
│           └── movie_card.dart
└── main.dart
