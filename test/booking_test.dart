import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_booking_app/services/fake_booking_service.dart';

void main() {
  group('FakeBookingService - Testes Unitários', () {
    late FakeBookingService service;

    setUp(() {
      service = FakeBookingService();
    });

    group('Testes de Disponibilidade (isAvailable)', () {
      test('Data disponível retorna true', () {
        final date = DateTime(2026, 5, 20);
        expect(service.isAvailable(date), true);
      });

      test('Data reservada (10/5) retorna false', () {
        final date = DateTime(2026, 5, 10);
        expect(service.isAvailable(date), false);
      });

      test('Data reservada (15/5) retorna false', () {
        final date = DateTime(2026, 5, 15);
        expect(service.isAvailable(date), false);
      });

      test('Data com mesmo dia mas ano diferente está disponível', () {
        final date = DateTime(2025, 5, 10);
        expect(service.isAvailable(date), true);
      });

      test('Data com mesmo dia mas mês diferente está disponível', () {
        final date = DateTime(2026, 6, 10);
        expect(service.isAvailable(date), true);
      });

      test('Múltiplas datas disponíveis', () {
        expect(service.isAvailable(DateTime(2026, 5, 1)), true);
        expect(service.isAvailable(DateTime(2026, 5, 8)), true);
        expect(service.isAvailable(DateTime(2026, 5, 20)), true);
        expect(service.isAvailable(DateTime(2026, 6, 1)), true);
      });
    });

    group('Testes de Reserva (book)', () {
      test('Reserva com sucesso uma data disponível', () {
        final date = DateTime(2026, 5, 20);
        expect(service.isAvailable(date), true);

        service.book(date);

        expect(service.isAvailable(date), false);
        expect(service.reservedDates.contains(date), true);
      });

      test('Quantidade de reservas aumenta após booking', () {
        final initialCount = service.reservedDates.length;
        final date = DateTime(2026, 5, 20);

        service.book(date);

        expect(service.reservedDates.length, initialCount + 1);
      });

      test('Não consegue reservar data já reservada', () {
        final date = DateTime(2026, 5, 10);
        final initialCount = service.reservedDates.length;

        service.book(date);

        expect(service.reservedDates.length, initialCount);
      });

      test('Reserva múltiplas datas diferentes', () {
        final date1 = DateTime(2026, 5, 20);
        final date2 = DateTime(2026, 5, 25);
        final date3 = DateTime(2026, 6, 1);

        service.book(date1);
        service.book(date2);
        service.book(date3);

        expect(service.isAvailable(date1), false);
        expect(service.isAvailable(date2), false);
        expect(service.isAvailable(date3), false);
      });

      test('Reserva completa afeta isAvailable corretamente', () {
        final date = DateTime(2026, 5, 20);

        // Antes da reserva
        expect(service.isAvailable(date), true);

        // Faz a reserva
        service.book(date);

        // Depois da reserva
        expect(service.isAvailable(date), false);
      });
    });

    group('Testes de Estado Inicial', () {
      test('Serviço inicia com 2 datas reservadas', () {
        expect(service.reservedDates.length, 2);
      });

      test('Datas iniciais são 10/5 e 15/5 de 2026', () {
        expect(service.reservedDates[0], DateTime(2026, 5, 10));
        expect(service.reservedDates[1], DateTime(2026, 5, 15));
      });

      test('Lista de reservas não é vazia', () {
        expect(service.reservedDates.isNotEmpty, true);
      });
    });

    group('Testes de Casos Extremos', () {
      test('Reservar mesma data consecutivamente', () {
        final date = DateTime(2026, 5, 20);

        service.book(date);
        expect(service.isAvailable(date), false);

        service.book(date);
        expect(service.isAvailable(date), false);

        // Deve ter apenas uma cópia da data
        final count = service.reservedDates
            .where(
              (d) =>
                  d.year == date.year &&
                  d.month == date.month &&
                  d.day == date.day,
            )
            .length;
        expect(count, 1);
      });

      test('Datas próximas são independentes', () {
        final date1 = DateTime(2026, 5, 20);
        final date2 = DateTime(2026, 5, 21);

        service.book(date1);

        expect(service.isAvailable(date1), false);
        expect(service.isAvailable(date2), true);
      });

      test('Anos diferentes são tratados independentemente', () {
        final date2026 = DateTime(2026, 5, 20);
        final date2027 = DateTime(2027, 5, 20);

        service.book(date2026);

        expect(service.isAvailable(date2026), false);
        expect(service.isAvailable(date2027), true);
      });

      test('Meses diferentes são tratados independentemente', () {
        final dateMaio = DateTime(2026, 5, 20);
        final dateJunho = DateTime(2026, 6, 20);

        service.book(dateMaio);

        expect(service.isAvailable(dateMaio), false);
        expect(service.isAvailable(dateJunho), true);
      });
    });

    group('Testes de Integração', () {
      test('Fluxo completo: verificar, reservar, verificar', () {
        final date = DateTime(2026, 5, 20);

        // Verifica disponibilidade
        expect(service.isAvailable(date), true);

        // Faz a reserva
        service.book(date);

        // Verifica que ficou indisponível
        expect(service.isAvailable(date), false);

        // Tenta reservar novamente (não deve fazer nada)
        service.book(date);

        // Continua indisponível
        expect(service.isAvailable(date), false);
      });

      test('Múltiplas operações de reserva', () {
        final dates = [
          DateTime(2026, 5, 20),
          DateTime(2026, 5, 21),
          DateTime(2026, 5, 22),
          DateTime(2026, 5, 23),
        ];

        // Reserva todas as datas
        for (final date in dates) {
          service.book(date);
        }

        // Verifica que todas estão indisponíveis
        for (final date in dates) {
          expect(service.isAvailable(date), false);
        }

        // Verifica que a quantidade de reservas está correta
        expect(service.reservedDates.length, 6); // 2 iniciais + 4 novas
      });
    });
  });
}
