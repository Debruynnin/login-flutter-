# 📅 Flutter Booking App

Um aplicativo Flutter completo de reservas com autenticação, gestão de datas e testes unitários abrangentes.

## 🎯 Funcionalidades

✅ **Tela de Login** - Autenticação com email e senha  
✅ **HomePage** - Bem-vindo do usuário com menu de navegação  
✅ **BookingScreen** - Seleção e visualização de datas reservadas  
✅ **Service Layer** - Lógica de negócio com FakeBookingService  
✅ **63 Testes Unitários** - Cobertura completa de service e widget  

## 📱 Telas do App

### 1. **Login Page** - `lib/main.dart`
- Email e senha com validações
- Mascara de senha com toggle
- Transição para HomePage após autenticação

```dart
_LoginPageState
- emailCtrl: TextEditingController
- senhaCtrl: TextEditingController
- _entrar(): Future<void> - Autentica usuário
```

### 2. **HomePage** - `lib/main.dart`
- Bem-vindo personalizado com nome do usuário
- Menu de navegação com 2 opções:
  - Reservar Data
  - Datas Reservadas
- Botão de logout

```dart
_HomePageState
- datasReservadas: List<DateTime>
- Acesso a ReservaDataPage e DatasReservadasPage
```

### 3. **BookingScreen** - `lib/screens/booking_screen.dart`
- AppBar com título "Reservas"
- Botão para selecionar nova data
- ListView com datas reservadas
- Status "Indisponível" em vermelho

```dart
_BookingScreenState
- service: FakeBookingService
- service.reservedDates: List<DateTime>
- service.isAvailable(date): bool
- service.book(date): void
```

## 🧪 Testes Unitários

### Service Tests - `test/booking_test.dart` (51 testes)

#### Testes de Disponibilidade
```dart
test('Data disponível retorna true')
test('Data reservada (10/5) retorna false')
test('Data reservada (15/5) retorna false')
test('Data com mesmo dia mas ano diferente está disponível')
test('Data com mesmo dia mas mês diferente está disponível')
test('Múltiplas datas disponíveis')
```

#### Testes de Reserva
```dart
test('Reserva com sucesso uma data disponível')
test('Quantidade de reservas aumenta após booking')
test('Não consegue reservar data já reservada')
test('Reserva múltiplas datas diferentes')
test('Reserva completa afeta isAvailable corretamente')
```

#### Testes de Estado Inicial
```dart
test('Serviço inicia com 2 datas reservadas')
test('Datas iniciais são 10/5 e 15/5 de 2026')
test('Lista de reservas não é vazia')
```

#### Testes de Casos Extremos
```dart
test('Reservar mesma data consecutivamente')
test('Datas próximas são independentes')
test('Anos diferentes são tratados independentemente')
test('Meses diferentes são tratados independentemente')
```

#### Testes de Integração
```dart
test('Fluxo completo: verificar, reservar, verificar')
test('Múltiplas operações de reserva')
```

### Widget Tests - `test/booking_screen_test.dart` (12 testes)

```dart
testWidgets('BookingScreen renderiza corretamente')
testWidgets('AppBar tem o título correto')
testWidgets('Botão de selecionar data existe')
testWidgets('ListView exibe as datas reservadas iniciais')
testWidgets('ListTile renderiza corretamente com data e subtítulo')
testWidgets('Coluna tem ElevatedButton e ListView')
testWidgets('ListView tem altura máxima com Expanded')
testWidgets('ListView é construído com ListView.builder')
testWidgets('BookingScreen usa StatefulWidget')
testWidgets('Dados são carregados no widget')
testWidgets('Widget constrói sem erros')
```

## 📊 Estrutura do Projeto

```
lib/
├── main.dart                    # LoginPage + HomePage
├── screens/
│   ├── booking_screen.dart      # Tela de reservas
│   └── login_screen.dart        # LoginScreen (alternativo)
└── services/
    └── fake_booking_service.dart # Serviço de reservas

test/
├── booking_test.dart            # 51 testes de service
├── booking_screen_test.dart     # 12 testes de widget
└── widget_test.dart             # Testes padrão Flutter
```

## 🚀 Como Executar

### Requisitos
- Flutter SDK 3.11.5+
- Dart 3.11.5+

### Instalar dependências
```bash
flutter pub get
```

### Rodar o app
```bash
flutter run -d web-server              # Web
flutter run -d windows                 # Windows
flutter run -d linux                   # Linux
```

### Executar testes
```bash
# Todos os testes
flutter test

# Testes específicos
flutter test test/booking_test.dart
flutter test test/booking_screen_test.dart

# Com cobertura
flutter test --coverage
```

## 📈 Estatísticas de Testes

| Métrica | Valor |
|---------|-------|
| Total de Testes | 63 |
| Testes de Service | 51 |
| Testes de Widget | 12 |
| Grupos de Teste | 9 |
| Cobertura | Lógica + UI |

## 🎨 Design

- **Tema:** Material Design 3
- **Cores Primárias:**
  - Verde Principal: `#4B5320`
  - Verde Secundário: `#676F53`
  - Fundo: `#FEFAE0`
- **Tipografia:** Darker Grotesque (Google Fonts)

## 📦 Dependências

```yaml
dependencies:
  flutter:
    sdk: flutter
  google_fonts: ^6.3.0
  cupertino_icons: ^1.0.8

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
```

## 📝 Licença

Este projeto é licenciado sob a licença MIT.

## 👨‍💻 Autor

Desenvolvido como projeto de reserva de datas com autenticação e testes completos.
