import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class AppColors {
  static const cream = Color(0xFFFEFAE0);
  static const primaryGreen = Color(0xFF4B5320);
  static const secondaryGreen = Color(0xFF676F53);
  static const textDark = Color(0xFF1B1B1B);
  static const cardBorder = Color(0x33000000);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.cream,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryGreen,
        brightness: Brightness.light,
        primary: AppColors.primaryGreen,
        secondary: AppColors.secondaryGreen,
        surface: Colors.white,
      ),
      textTheme: GoogleFonts.darkerGrotesqueTextTheme(
        ThemeData.light().textTheme,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: base.copyWith(
        textTheme: base.textTheme.copyWith(
          headlineLarge: GoogleFonts.darkerGrotesque(
            fontSize: 40,
            fontWeight: FontWeight.w800,
            color: AppColors.textDark,
          ),
          titleLarge: GoogleFonts.darkerGrotesque(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
          bodyLarge: GoogleFonts.darkerGrotesque(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.textDark,
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailCtrl = TextEditingController();
  final senhaCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool esconderSenha = true;
  bool carregando = false;

  @override
  void dispose() {
    emailCtrl.dispose();
    senhaCtrl.dispose();
    super.dispose();
  }

  Future<void> _entrar() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => carregando = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => carregando = false);

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HomePage(nomeUsuario: emailCtrl.text.trim()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.cardBorder),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 18,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: AppColors.primaryGreen,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.lock, color: Colors.white),
                          ),
                          const SizedBox(width: 10),
                          Text('Entrar', style: t.headlineLarge),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Faça login para acessar o aplicativo.',
                        style: t.bodyLarge?.copyWith(
                          color: AppColors.secondaryGreen,
                        ),
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        controller: emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          prefixIcon: const Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (v) {
                          final value = (v ?? '').trim();
                          if (value.isEmpty) return 'Informe seu e-mail';
                          if (!value.contains('@')) return 'E-mail inválido';
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: senhaCtrl,
                        obscureText: esconderSenha,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                esconderSenha = !esconderSenha;
                              });
                            },
                            icon: Icon(
                              esconderSenha
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (v) {
                          final value = (v ?? '').trim();
                          if (value.isEmpty) return 'Informe sua senha';
                          if (value.length < 4) return 'Senha muito curta';
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: carregando ? null : _entrar,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryGreen,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: carregando
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Entrar',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('Criar conta'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final String nomeUsuario;

  const HomePage({super.key, required this.nomeUsuario});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<DateTime> datasReservadas = [
    DateTime(2025, 5, 10),
    DateTime(2025, 5, 15),
    DateTime(2025, 5, 20),
  ];

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
        title: const Text('Reservas'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Sair',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Text('Bem-vindo!', style: t.headlineSmall),
            Text(
              'Usuário: ${widget.nomeUsuario}',
              style: t.bodyLarge?.copyWith(color: AppColors.secondaryGreen),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReservaDataPage(
                      datasReservadas: datasReservadas,
                    ),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month,
                        size: 34, color: AppColors.primaryGreen),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reservar Data',
                            style: t.titleLarge,
                          ),
                          Text(
                            'Escolha uma data disponível',
                            style: t.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        DatasReservadasPage(datasReservadas: datasReservadas),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.event_busy,
                        size: 34, color: AppColors.primaryGreen),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Datas Reservadas',
                            style: t.titleLarge,
                          ),
                          Text(
                            'Veja as datas já cadastradas',
                            style: t.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReservaDataPage extends StatefulWidget {
  final List<DateTime> datasReservadas;

  const ReservaDataPage({super.key, required this.datasReservadas});

  @override
  State<ReservaDataPage> createState() => _ReservaDataPageState();
}

class _ReservaDataPageState extends State<ReservaDataPage> {
  DateTime? dataSelecionada;
  String? mensagem;

  Future<void> escolherData() async {
    final hoje = DateTime.now();
    final escolhida = await showDatePicker(
      context: context,
      firstDate: hoje,
      lastDate: DateTime(2030),
      initialDate: hoje,
    );

    if (escolhida == null) return;

    setState(() {
      dataSelecionada = DateTime(escolhida.year, escolhida.month, escolhida.day);
      mensagem = null;
    });
  }

  void reservar() {
    if (dataSelecionada == null) return;

    final existe = widget.datasReservadas.any(
      (d) =>
          d.year == dataSelecionada!.year &&
          d.month == dataSelecionada!.month &&
          d.day == dataSelecionada!.day,
    );

    setState(() {
      mensagem = existe
          ? 'Essa data já está reservada.'
          : 'Data reservada com sucesso!';
    });

    if (!existe) {
      widget.datasReservadas.add(dataSelecionada!);
      widget.datasReservadas.sort((a, b) => a.compareTo(b));
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            dataSelecionada = null;
          });
        }
      });
    }
  }

  String formatarData(DateTime data) {
    final dia = data.day.toString().padLeft(2, '0');
    final mes = data.month.toString().padLeft(2, '0');
    final ano = data.year.toString();
    return '$dia/$mes/$ano';
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final preview = [...widget.datasReservadas]..sort((a, b) => a.compareTo(b));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservar Data'),
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selecione uma data para reserva:',
              style: t.titleMedium,
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: escolherData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Escolher data'),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: dataSelecionada == null
                    ? Colors.white
                    : AppColors.cream.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: Text(
                dataSelecionada == null
                    ? 'Nenhuma data selecionada'
                    : 'Data selecionada: ${formatarData(dataSelecionada!)}',
                style: t.bodyLarge,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: dataSelecionada == null ? null : reservar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Reservar data'),
              ),
            ),
            if (mensagem != null) ...[
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: mensagem!.contains('sucesso')
                      ? const Color(0xFFEAF5E3)
                      : const Color(0xFFFFE9E9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(mensagem!),
              ),
            ],
            const SizedBox(height: 16),
            Text('Datas reservadas (fake):', style: t.titleMedium),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                itemCount: preview.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.event_busy, color: Colors.redAccent),
                        const SizedBox(width: 10),
                        Text(formatarData(preview[index])),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DatasReservadasPage extends StatelessWidget {
  final List<DateTime> datasReservadas;

  const DatasReservadasPage({super.key, required this.datasReservadas});

  String formatarData(DateTime data) {
    final dia = data.day.toString().padLeft(2, '0');
    final mes = data.month.toString().padLeft(2, '0');
    final ano = data.year.toString();
    return '$dia/$mes/$ano';
  }

  @override
  Widget build(BuildContext context) {
    final datasOrdenadas = [...datasReservadas]..sort((a, b) => a.compareTo(b));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Datas Indisponíveis'),
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.cream,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: const Text('Lista fake de datas já reservadas.'),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: datasOrdenadas.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, index) => ListTile(
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: AppColors.cardBorder),
                  ),
                  leading: const Icon(Icons.event_busy, color: Colors.redAccent),
                  title: Text(formatarData(datasOrdenadas[index])),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
