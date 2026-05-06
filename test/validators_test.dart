import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/services/validators.dart';

void main() {
  group('Validators', () {
    group('validateEmail', () {
      test('deve retornar null para email válido', () {
        final result = Validators.validateEmail('usuario@example.com');
        expect(result, isNull);
      });

      test('deve retornar erro para email vazio', () {
        final result = Validators.validateEmail('');
        expect(result, 'Email é obrigatório');
      });

      test('deve retornar erro para email null', () {
        final result = Validators.validateEmail(null);
        expect(result, 'Email é obrigatório');
      });

      test('deve retornar erro para email sem @', () {
        final result = Validators.validateEmail('usuarioexample.com');
        expect(result, 'Email inválido');
      });

      test('deve retornar erro para email sem domínio', () {
        final result = Validators.validateEmail('usuario@');
        expect(result, 'Email inválido');
      });

      test('deve aceitar emails com múltiplos pontos', () {
        final result = Validators.validateEmail('usuario@mail.co.uk');
        expect(result, isNull);
      });
    });

    group('validatePassword', () {
      test('deve retornar null para senha válida', () {
        final result = Validators.validatePassword('senha123');
        expect(result, isNull);
      });

      test('deve retornar erro para senha vazia', () {
        final result = Validators.validatePassword('');
        expect(result, 'Senha é obrigatória');
      });

      test('deve retornar erro para senha null', () {
        final result = Validators.validatePassword(null);
        expect(result, 'Senha é obrigatória');
      });

      test('deve retornar erro para senha com menos de 6 caracteres', () {
        final result = Validators.validatePassword('abc12');
        expect(result, 'Senha deve ter no mínimo 6 caracteres');
      });

      test('deve aceitar senha com exatamente 6 caracteres', () {
        final result = Validators.validatePassword('abc123');
        expect(result, isNull);
      });
    });

    group('validateName', () {
      test('deve retornar null para nome válido', () {
        final result = Validators.validateName('João Silva');
        expect(result, isNull);
      });

      test('deve retornar erro para nome vazio', () {
        final result = Validators.validateName('');
        expect(result, 'Nome é obrigatório');
      });

      test('deve retornar erro para nome null', () {
        final result = Validators.validateName(null);
        expect(result, 'Nome é obrigatório');
      });

      test('deve retornar erro para nome com menos de 3 caracteres', () {
        final result = Validators.validateName('Jo');
        expect(result, 'Nome deve ter no mínimo 3 caracteres');
      });

      test('deve aceitar nome com exatamente 3 caracteres', () {
        final result = Validators.validateName('Ana');
        expect(result, isNull);
      });
    });

    group('validatePasswordMatch', () {
      test('deve retornar null quando senhas coincidem', () {
        final result = Validators.validatePasswordMatch('senha123', 'senha123');
        expect(result, isNull);
      });

      test('deve retornar erro para confirmação vazia', () {
        final result = Validators.validatePasswordMatch('', 'senha123');
        expect(result, 'Confirmação de senha é obrigatória');
      });

      test('deve retornar erro para confirmação null', () {
        final result = Validators.validatePasswordMatch(null, 'senha123');
        expect(result, 'Confirmação de senha é obrigatória');
      });

      test('deve retornar erro quando senhas não coincidem', () {
        final result = Validators.validatePasswordMatch('senha123', 'senha456');
        expect(result, 'As senhas não coincidem');
      });
    });
  });
}
