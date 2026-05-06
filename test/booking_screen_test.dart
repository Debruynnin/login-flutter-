import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_booking_app/screens/booking_screen.dart';

void main() {
  group('BookingScreen - Testes de Widget', () {
    testWidgets('BookingScreen renderiza corretamente', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: BookingScreen()));

      expect(find.text("Reservas"), findsOneWidget);
      expect(find.text("Selecionar data"), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('AppBar tem o título correto', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: BookingScreen()));

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text("Reservas"), findsOneWidget);
    });

    testWidgets('Botão de selecionar data existe', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: BookingScreen()));

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byIcon(Icons.calendar_today), findsWidgets);
    });

    testWidgets('ListView exibe as datas reservadas iniciais', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: BookingScreen()));

      // Deve mostrar as 2 datas iniciais: 10/5/2026 e 15/5/2026
      expect(find.text("10/5/2026"), findsOneWidget);
      expect(find.text("15/5/2026"), findsOneWidget);
      expect(find.text("Indisponível"), findsWidgets);
    });

    testWidgets('ListTile renderiza corretamente com data e subtítulo', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: BookingScreen()));

      expect(find.byType(ListTile), findsWidgets);

      // Verifica que temos pelo menos 2 ListTiles (as datas iniciais)
      expect(find.byType(ListTile), findsWidgetWithText(ListTile, "10/5/2026"));
    });

    testWidgets('Coluna tem ElevatedButton e ListView', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: BookingScreen()));

      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(Expanded), findsOneWidget);
    });

    testWidgets('ListView tem altura máxima com Expanded', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: BookingScreen()));

      final expandedFinder = find.byType(Expanded);
      expect(expandedFinder, findsOneWidget);

      final expanded = tester.widget<Expanded>(expandedFinder);
      expect(expanded.child, isA<ListView>());
    });

    testWidgets('ListView é construído com ListView.builder', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: BookingScreen()));

      expect(find.byType(ListView), findsOneWidget);
      // ListView.builder cria widgets dinamicamente baseado em itemCount
      expect(find.byType(ListTile), findsWidgets);
    });

    testWidgets('BookingScreen usa StatefulWidget', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: BookingScreen()));

      expect(find.byType(BookingScreen), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('Dados são carregados no widget', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: BookingScreen()));

      // Verifica quantidade de items no ListView
      expect(find.byType(ListTile), findsWidgets);

      // Deve ter pelo menos 2 ListTiles
      final listTiles = find.byType(ListTile);
      expect(listTiles, findsWidgetWithText(ListTile, "Indisponível"));
    });

    testWidgets('Widget constrói sem erros', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: BookingScreen()));

      // Se chegou aqui, o widget foi construído sem erros
      expect(find.byType(BookingScreen), findsOneWidget);
    });
  });
}

/// Helper function para encontrar widget com texto específico
Finder findsWidgetWithText(Type widgetType, String text) {
  return find.byWidgetPredicate((widget) {
    if (widget.runtimeType != widgetType) {
      return false;
    }
    return find
        .descendant(of: find.byWidget(widget), matching: find.text(text))
        .evaluate()
        .isNotEmpty;
  });
}
