import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mon Application',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF00A000)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Page d\'accueil'),
        '/profile': (context) => const ProfilePage(),
        '/settings': (context) => const SettingsPage(),
        '/help': (context) => const HelpPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  String _genre = 'Homme';
  bool _codage = false;
  bool _design = false;
  bool _gaming = false;
  DateTime _selectedDate = DateTime.now();
  double _competenceLevel = 1.0;
  String _formation = 'Informatique';
  bool _notifications = false;

  @override
  void dispose() {
    _nomController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero, // Supprime le padding par défaut
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person_4_outlined,
                    size: 40,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Bonjour !',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                Text(
                  'Anass Loriga',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Accueil'),
            onTap: () {
              Navigator.pop(context);
              // Déjà sur la page d'accueil, donc pas besoin de naviguer
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profil'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Paramètres'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/settings');
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Aide'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/help');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('Déconnexion', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              // Afficher une boîte de dialogue de confirmation
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Déconnexion'),
                  content: Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Annuler'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Vous avez été déconnecté')),
                        );
                      },
                      child: Text('Confirmer'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Entrez votre nom :', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            TextField(
              controller: _nomController,
              decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Votre nom'),
            ),
            SizedBox(height: 16),
            Text('Entrez votre âge :', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Votre âge'),
            ),
            SizedBox(height: 16),
            Text('Genre :', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Radio<String>(
                  value: 'Homme',
                  groupValue: _genre,
                  onChanged: (value) => setState(() => _genre = value!),
                ),
                Text('Homme'),
                SizedBox(width: 20),
                Radio<String>(
                  value: 'Femme',
                  groupValue: _genre,
                  onChanged: (value) => setState(() => _genre = value!),
                ),
                Text('Femme'),
              ],
            ),
            SizedBox(height: 16),
            Text('Centres d\'intérêt :', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            CheckboxListTile(
              title: Text('Codage'),
              value: _codage,
              onChanged: (value) => setState(() => _codage = value!),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text('Design'),
              value: _design,
              onChanged: (value) => setState(() => _design = value!),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text('Jeux vidéo'),
              value: _gaming,
              onChanged: (value) => setState(() => _gaming = value!),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            SizedBox(height: 16),
            Text('Date de naissance :', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Text("${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}"),
                Spacer(),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Sélectionner'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('Niveau en programmation (1-5) :', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Text('Débutant'),
                Expanded(
                  child: Slider(
                    value: _competenceLevel,
                    min: 1.0,
                    max: 5.0,
                    divisions: 4,
                    label: _competenceLevel.round().toString(),
                    onChanged: (value) => setState(() => _competenceLevel = value),
                  ),
                ),
                Text('Expert'),
              ],
            ),
            SizedBox(height: 16),
            Text('Formation :', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _formation,
              onChanged: (value) => setState(() => _formation = value!),
              items: ['Informatique', 'Design', 'Marketing', 'Gestion']
                  .map((value) => DropdownMenuItem<String>(value: value, child: Text(value)))
                  .toList(),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recevoir des notifications :', style: TextStyle(fontSize: 16)),
                Switch(
                  value: _notifications,
                  onChanged: (value) => setState(() => _notifications = value),
                ),
              ],
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  String nom = _nomController.text.trim();
                  String age = _ageController.text.trim();

                  if (nom.isEmpty || age.isEmpty || int.tryParse(age) == null || int.parse(age) <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Veuillez entrer un nom et un âge valide.')),
                    );
                    return;
                  }

                  String message = 'Profil : $nom, $age ans, $_genre\n';
                  message += 'Formation : $_formation\n';
                  message += 'Date de naissance : ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}\n';
                  message += 'Niveau : ${_competenceLevel.round()}/5\n';
                  message += 'Intérêts : ';
                  if (_codage) message += 'Codage, ';
                  if (_design) message += 'Design, ';
                  if (_gaming) message += 'Jeux vidéo, ';
                  message += '\nNotifications : ${_notifications ? "Oui" : "Non"}';

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Profil complet'),
                      content: Text(message),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Fermer'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text('Valider le formulaire'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(
                Icons.person,
                size: 70,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Informations du Profil',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20),
              elevation: 3,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildProfileInfoRow(Icons.badge, 'Nom', 'Anass Loriga'),
                    Divider(),
                    _buildProfileInfoRow(Icons.email, 'Email', 'LorigaAnass@gmail.com'),
                    Divider(),
                    _buildProfileInfoRow(Icons.phone, 'Téléphone', '+212 612345678'),
                    Divider(),
                    _buildProfileInfoRow(Icons.school, 'Formation', 'DEVOAM'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Retour à l\'accueil'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildProfileInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.green),
          SizedBox(width: 10),
          Text(
            '$label : ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  double _fontSize = 16;
  String _language = 'Français';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paramètres'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildSectionTitle('Préférences d\'affichage'),
          Card(
            elevation: 2,
            child: Column(
              children: [
                SwitchListTile(
                  title: Text('Mode sombre'),
                  subtitle: Text('Changer l\'apparence de l\'application'),
                  value: _darkModeEnabled,
                  onChanged: (value) {
                    setState(() {
                      _darkModeEnabled = value;
                    });
                  },
                  secondary: Icon(Icons.brightness_4),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.format_size),
                  title: Text('Taille de police'),
                  subtitle: Slider(
                    value: _fontSize,
                    min: 12,
                    max: 24,
                    divisions: 6,
                    label: _fontSize.round().toString(),
                    onChanged: (value) {
                      setState(() {
                        _fontSize = value;
                      });
                    },
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.language),
                  title: Text('Langue'),
                  subtitle: Text(_language),
                  trailing: DropdownButton<String>(
                    value: _language,
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          _language = value;
                        });
                      }
                    },
                    items: <String>['Français', 'English', 'العربية', 'Espanol']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    underline: Container(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          _buildSectionTitle('Notifications'),
          Card(
            elevation: 2,
            child: Column(
              children: [
                SwitchListTile(
                  title: Text('Activer les notifications'),
                  subtitle: Text('Recevoir des alertes et mises à jour'),
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                  secondary: Icon(Icons.notifications),
                ),
                if (_notificationsEnabled) ...[
                  Divider(),
                  CheckboxListTile(
                    title: Text('Notifications par email'),
                    value: true,
                    onChanged: (value) {},
                    secondary: Icon(Icons.email),
                  ),
                  Divider(),
                  CheckboxListTile(
                    title: Text('Notifications push'),
                    value: true,
                    onChanged: (value) {},
                    secondary: Icon(Icons.notifications),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: 20),
          _buildSectionTitle('Sécurité'),
          Card(
            elevation: 2,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.lock),
                  title: Text('Changer le mot de passe'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Fonction non implémentée')),
                    );
                  },
                ),
                Divider(),
                SwitchListTile(
                  title: Text('Authentification biométrique'),
                  subtitle: Text('Utiliser votre empreinte digitale pour vous connecter'),
                  value: false,
                  onChanged: (value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Fonction non implémentée')),
                    );
                  },
                  secondary: Icon(Icons.fingerprint),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Center(
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Sauvegarder les modifications'),
                    content: Text('Voulez-vous enregistrer vos modifications ?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Annuler'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Paramètres sauvegardés')),
                          );
                        },
                        child: Text('Sauvegarder'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Enregistrer les modifications'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aide'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                Icons.help_outline,
                size: 70,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Comment utiliser l\'application',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            _buildFAQItem(
              context,
              'Comment remplir le formulaire ?',
              'Sur la page d\'accueil, vous trouverez un formulaire à remplir avec vos informations personnelles. Assurez-vous de compléter tous les champs obligatoires marqués par un astérisque, puis cliquez sur le bouton "Valider le formulaire" pour soumettre vos informations.'
            ),
            _buildFAQItem(
              context,
              'Comment modifier mes informations de profil ?',
              'Vous pouvez accéder à votre profil en cliquant sur l\'option "Profil" dans le menu latéral. Sur cette page, vous pourrez consulter et modifier vos informations personnelles. N\'oubliez pas de sauvegarder vos modifications.'
            ),
            _buildFAQItem(
              context,
              'Comment changer la langue de l\'application ?',
              'Pour changer la langue, accédez à la page "Paramètres" depuis le menu latéral. Dans la section "Préférences d\'affichage", vous trouverez l\'option "Langue" où vous pourrez sélectionner la langue de votre choix parmi celles disponibles.'
            ),
            _buildFAQItem(
              context,
              'Comment activer/désactiver les notifications ?',
              'Dans la page "Paramètres", vous trouverez une section dédiée aux notifications. Utilisez l\'interrupteur pour activer ou désactiver les notifications. Vous pouvez également configurer les types de notifications que vous souhaitez recevoir.'
            ),
            SizedBox(height: 30),
            Text(
              'Besoin d\'aide supplémentaire ?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Contactez notre support technique :'),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.email, color: Colors.green),
                        SizedBox(width: 10),
                        Text('support@example.com'),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.phone, color: Colors.green),
                        SizedBox(width: 10),
                        Text('+212 522 123 456'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Retour à l\'accueil'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildFAQItem(BuildContext context, String question, String answer) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      child: ExpansionTile(
        title: Text(
          question,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              answer,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}