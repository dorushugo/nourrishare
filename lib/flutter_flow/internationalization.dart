import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['fr', 'en'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? frText = '',
    String? enText = '',
  }) =>
      [frText, enText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // Connexion
  {
    'wsbqe3ga': {
      'fr': 'Adresse mail',
      'en': 'Mail address',
    },
    '8y1xmovj': {
      'fr': 'exemple@mail.fr',
      'en': 'example@mail.fr',
    },
    'djpn06rw': {
      'fr': 'Mot de passe',
      'en': 'Password',
    },
    'eatzmrue': {
      'fr': '***********',
      'en': '***********',
    },
    'wtvcp4a8': {
      'fr': 'Se connecter',
      'en': 'Log in',
    },
    'moemsbho': {
      'fr': 'Mot de passe oublié ?',
      'en': 'Forgot your password ?',
    },
    '12ao2y69': {
      'fr': 'ou continuez avec',
      'en': 'or continue with',
    },
    'hkgr1auf': {
      'fr': 'Se connecter avec Google',
      'en': 'Sign in with Google',
    },
    'mvvp694k': {
      'fr': 'Se connecter avec Apple',
      'en': 'Sign in with Apple',
    },
    'cdu6aoqr': {
      'fr': 'Connexion',
      'en': 'Connection',
    },
    'ri917tjc': {
      'fr': 'Connexion',
      'en': 'Connection',
    },
  },
  // Onboarding
  {
    '49lxxxk8': {
      'fr': 'Vendez vos plats à vos voisins et vos collègues',
      'en': 'Sell ​​your dishes to your neighbors and colleagues',
    },
    'k03iab1u': {
      'fr':
          'En quelques clics, vendez des portions de ce que vous avez cuisiné !',
      'en': 'In just a few clicks, sell portions of what you\'ve cooked!',
    },
    '7ogouj21': {
      'fr': 'Remboursez vos courses et mangez gratuitement',
      'en': 'Reimburse your groceries and eat for free',
    },
    '63bl8eng': {
      'fr': 'En cuisinant en plus grande quantité et en vendant le surplus.',
      'en': 'By cooking in larger quantities and selling the surplus.',
    },
    'ox0l4nyt': {
      'fr': 'Mangez plus sain en dépensant moins',
      'en': 'Eat healthier while spending less',
    },
    '9vsupxxi': {
      'fr': 'Économisez grâce à des repas plus abordables fait maison.',
      'en': 'Save money with more affordable home-cooked meals.',
    },
    '5vfu49lg': {
      'fr': 'Onboarding',
      'en': 'Onboarding',
    },
  },
  // Profilpage
  {
    'rod7jq2g': {
      'fr': 'Plats favoris',
      'en': 'Favorite dishes',
    },
    'uowi0qc1': {
      'fr': 'Plats en ventes',
      'en': 'Dishes on sale',
    },
    't569y3uk': {
      'fr': 'Déconnexion',
      'en': 'Disconnect',
    },
    'kb9vgzb9': {
      'fr': 'Activer les paiements',
      'en': 'Enable payments',
    },
    '0zolelaj': {
      'fr': 'Supprimer mon compte',
      'en': 'Delete my account',
    },
    'zqq22o1n': {
      'fr': 'Profil',
      'en': 'Profile',
    },
  },
  // Accueil
  {
    'u5jq0tzy': {
      'fr': 'Plats proches de vous',
      'en': 'Dishes near you',
    },
    'xxqm8eoh': {
      'fr': 'Voir tout',
      'en': 'See everything',
    },
    'ip94oal6': {
      'fr': 'Ingrédients proches de vous',
      'en': 'Ingredients close to you',
    },
    'p5k18teh': {
      'fr': 'Voir tout',
      'en': 'See everything',
    },
    'ybsdhvfj': {
      'fr': 'Plats de vos collègues',
      'en': 'Your colleagues\' dishes',
    },
    'rzay7440': {
      'fr': 'Voir tout',
      'en': 'See everything',
    },
    'tg72k2oa': {
      'fr': 'Ingrédients de vos collègues',
      'en': 'Ingredients from your colleagues',
    },
    'yfe6rumj': {
      'fr': 'Voir tout',
      'en': 'See everything',
    },
    'bj2r0pcj': {
      'fr': 'Home',
      'en': 'Home',
    },
  },
  // Plats_details
  {
    '12137qrb': {
      'fr': ' €',
      'en': '€',
    },
    '7crs44s5': {
      'fr': 'Ingrédients',
      'en': 'Ingredients',
    },
    'q7ybyfqo': {
      'fr': 'Allergènes',
      'en': 'Allergens',
    },
    'vzw22tb1': {
      'fr': 'Commander',
      'en': 'Order',
    },
    'w12vy2h2': {
      'fr': 'Modifier le plat',
      'en': 'Edit the dish',
    },
    'ofjtgcbw': {
      'fr': 'Supprimer le plat',
      'en': 'Remove dish',
    },
    '9tuzsrdy': {
      'fr': 'Commander un plat',
      'en': 'Order a dish',
    },
    '9zm78y73': {
      'fr': 'Commander pour maintenant',
      'en': 'Order now',
    },
    'n1o6wp6b': {
      'fr':
          'Vous serez servie dès que le plat sera prêt. (Ex : Service dans 30 minutes)',
      'en':
          'You will be served as soon as the dish is ready. (Ex: Service in 30 minutes)',
    },
    'w0u2lfph': {
      'fr': 'Sélectionner',
      'en': 'Select',
    },
    'ah4cwcb3': {
      'fr': 'Commander pour plus tard',
      'en': 'Order for later',
    },
    't5gv4bag': {
      'fr':
          'Votre plat sera prêt pour le jour souhaité.  \n(Ex : Service jeudi midi)',
      'en':
          'Your dish will be ready for the desired day.\n(Ex: Thursday lunchtime service)',
    },
    't58po2fe': {
      'fr': 'Sélectionner',
      'en': 'Select',
    },
    'qqwsupqa': {
      'fr': 'Commander un plat',
      'en': 'Order a dish',
    },
    '3onrkbz4': {
      'fr': 'Commander pour plus tard',
      'en': 'Order for later',
    },
    'p9bs8wfc': {
      'fr':
          'Votre plat sera prêt pour le jour souhaité.  \n(Ex : Service jeudi midi)',
      'en':
          'Your dish will be ready for the desired day.\n(Ex: Thursday lunchtime service)',
    },
    '2r9n2vsm': {
      'fr': 'Le matin',
      'en': 'The morning',
    },
    's865kwcy': {
      'fr': 'Le midi ',
      'en': 'Noon',
    },
    'v98hrt2h': {
      'fr': 'Le soir',
      'en': 'The evening',
    },
    '6p948i3m': {
      'fr': 'Quand souhaitez-vous être servi(e) ? ',
      'en': 'When would you like to be served?',
    },
    '3ezftg0h': {
      'fr': 'Search for an item...',
      'en': 'Search for an item...',
    },
    'ntquk1np': {
      'fr': 'Commander',
      'en': 'Order',
    },
    'ov9s26ii': {
      'fr': 'Home',
      'en': 'Home',
    },
  },
  // vendeur_detail
  {
    'a4yxtgys': {
      'fr': 'Plats en ventes à ses voisins',
      'en': 'Dishes for sale to neighbors',
    },
    'cp9axlkg': {
      'fr': 'Plats en ventes dans vos groupes',
      'en': 'Dishes on sale in your groups',
    },
    'r9gtb7es': {
      'fr': 'Chatter',
      'en': 'Chat',
    },
    'uinv0rqs': {
      'fr': 'Home',
      'en': 'Home',
    },
  },
  // ajouterunplat
  {
    '3hdok3ay': {
      'fr': 'Ajouter un plat',
      'en': 'Add a dish',
    },
    '3rjtndow': {
      'fr': 'Ajouter une photo',
      'en': 'Add a picture',
    },
    'zwee7e8u': {
      'fr': 'Nom du plat',
      'en': 'Name of the dish',
    },
    '9as5z72n': {
      'fr': 'Ingrédient',
      'en': 'Ingredient',
    },
    'c94eta0y': {
      'fr': 'Plat cuisiné',
      'en': 'A cooked dish',
    },
    'g52c51q4': {
      'fr': 'Quel type de plat ?',
      'en': 'What type of dish?',
    },
    'yk0vmzhi': {
      'fr': 'Search for an item...',
      'en': 'Search for an item...',
    },
    'u8bkl9wn': {
      'fr': 'Prix',
      'en': 'Price',
    },
    '3rrktdr7': {
      'fr': 'Ingrédients',
      'en': 'Ingredients',
    },
    'qx828l49': {
      'fr': 'Allergènes',
      'en': 'Allergens',
    },
    'ig40dhzn': {
      'fr': 'Quantité',
      'en': 'Quantity',
    },
    '0wbsakeq': {
      'fr': 'À qui souhaitez vous vendre ce plat ?',
      'en': 'Who do you want to sell this dish to?',
    },
    '7z3q2wfo': {
      'fr': 'Mes voisins',
      'en': 'My neighbors',
    },
    '9ip8apxc': {
      'fr': 'Toutes les personnes dans mes groupes',
      'en': 'Everyone in my groups',
    },
    '4163gfcg': {
      'fr': 'À tout le monde (voisins et groupes)',
      'en': 'To everyone (neighbors and groups)',
    },
    'kcbpju6u': {
      'fr': 'À un ou des groupes en particulier',
      'en': 'To one or more groups in particular',
    },
    '2dk0pmzr': {
      'fr': 'À qui voulez vous proposer ce plat ?',
      'en': 'Who do you want to offer this dish to?',
    },
    '6rtcuchn': {
      'fr': 'Search for an item...',
      'en': 'Search for an item...',
    },
    '0vm2v0ft': {
      'fr': 'À quels groupes voulez-vous vendre ?',
      'en': 'Which groups do you want to sell to?',
    },
    'megvzirk': {
      'fr': 'Mettre en vente',
      'en': 'To put up for sale',
    },
    '58fwbvsg': {
      'fr': 'Field is required',
      'en': 'Field is required',
    },
    'rykhmf3u': {
      'fr': 'Please choose an option from the dropdown',
      'en': 'Please choose an option from the dropdown',
    },
    'q926wekc': {
      'fr': 'Field is required',
      'en': 'Field is required',
    },
    '6mffz9cz': {
      'fr': 'Please choose an option from the dropdown',
      'en': 'Please choose an option from the dropdown',
    },
    '8mqwkqxc': {
      'fr': 'Field is required',
      'en': 'Field is required',
    },
    'w1ugb096': {
      'fr': 'Please choose an option from the dropdown',
      'en': 'Please choose an option from the dropdown',
    },
    'udzaj63k': {
      'fr': 'Field is required',
      'en': 'Field is required',
    },
    '1l9skn8y': {
      'fr': 'Please choose an option from the dropdown',
      'en': 'Please choose an option from the dropdown',
    },
    '9ku51008': {
      'fr': 'Home',
      'en': 'Home',
    },
  },
  // Profilcompletion
  {
    'l5ccw9u6': {
      'fr': 'Prenom',
      'en': 'First name',
    },
    'xt8nf750': {
      'fr': 'Nom',
      'en': 'Name',
    },
    'cjdrmk55': {
      'fr': 'Adresse email',
      'en': 'E-mail address',
    },
    'zokk5smv': {
      'fr': '🇫🇷  (+33) France ',
      'en': '🇫🇷 (+33) France',
    },
    '5ve9mo3y': {
      'fr': '🇺🇸  (+1) USA',
      'en': '🇺🇸 (+1) USA',
    },
    'ngnehpom': {
      'fr': 'Please select...',
      'en': 'Please select...',
    },
    'lcd0w5z7': {
      'fr': 'Rechercher',
      'en': 'To research',
    },
    'aohfag6y': {
      'fr': 'Numéro de téléphone',
      'en': 'Phone number',
    },
    '3xx2s5ju': {
      'fr': '612345678',
      'en': '612345678',
    },
    '0lewlph0': {
      'fr': 'Je veux vendre des plats',
      'en': 'I want to sell dishes',
    },
    'dv0qb794': {
      'fr': 'Ajouter mon adresse',
      'en': 'Add my address',
    },
    't9qucslm': {
      'fr': 'Confirmer',
      'en': 'Confirm',
    },
    'fv9yvaph': {
      'fr': 'Compléter votre profil',
      'en': 'Complete your profile',
    },
    'bxm1wwfa': {
      'fr': 'Home',
      'en': 'Home',
    },
  },
  // messageList
  {
    'kcxffa97': {
      'fr': 'Messages',
      'en': 'Messages',
    },
    'k7t97rcq': {
      'fr': 'Nouveau chat',
      'en': 'New cat',
    },
    'pfawsnhj': {
      'fr': 'Vos groupes',
      'en': 'Your groups',
    },
    '1f1l44z6': {
      'fr': 'Chatter',
      'en': 'Chat',
    },
    'ylofgfof': {
      'fr': 'Vos conversations',
      'en': 'Your conversations',
    },
    'l3vc2fxa': {
      'fr': 'Chatter',
      'en': 'Chat',
    },
    'j970szos': {
      'fr': 'Home',
      'en': 'Home',
    },
  },
  // chatPage
  {
    'nteh7hgc': {
      'fr': 'Commencez à écrire',
      'en': 'Start writing',
    },
    'jefcjod6': {
      'fr': 'Home',
      'en': 'Home',
    },
  },
  // rechercheMessage
  {
    'sdr0n4cj': {
      'fr': 'Rechercher',
      'en': 'To research',
    },
    'xa701du0': {
      'fr': 'Rechercher un groupe ou un utilisateur',
      'en': 'Search for a group or user',
    },
    '9304nbob': {
      'fr': 'Groupes',
      'en': 'Groups',
    },
    '13osjouc': {
      'fr': 'Créer un groupe',
      'en': 'Create a group',
    },
    'ei70a6op': {
      'fr': 'Voir',
      'en': 'See',
    },
    'zqqbuuco': {
      'fr': 'Utilisateurs',
      'en': 'Users',
    },
    'mm0ggpob': {
      'fr': 'Partager l\'app',
      'en': 'Share the app',
    },
    'nag3rh4i': {
      'fr': 'Voir',
      'en': 'See',
    },
    'x1urim0m': {
      'fr': 'Home',
      'en': 'Home',
    },
  },
  // Inscription
  {
    '4k7z1ewa': {
      'fr': 'Inscription',
      'en': 'Registration',
    },
    'rv0zcxnn': {
      'fr': 'Adresse mail',
      'en': 'Mail address',
    },
    'lp12jn17': {
      'fr': 'exemple@mail.fr',
      'en': 'example@mail.fr',
    },
    'sbi222bk': {
      'fr': 'Mot de passe',
      'en': 'Password',
    },
    'pldg06xm': {
      'fr': '***********',
      'en': '*****',
    },
    '1ua5tjyo': {
      'fr': 'S\'inscrire',
      'en': 'Register',
    },
    'piyb6vt9': {
      'fr': 'ou continuez avec',
      'en': 'or continue with',
    },
    'mf2y0q0f': {
      'fr': 'Continuer avec Google',
      'en': 'Continue with Google',
    },
    'i7jcld19': {
      'fr': 'Continuer avec Apple',
      'en': 'Continue with Apple',
    },
    '2px6vamv': {
      'fr': 'En continuant, vous acceptez nos',
      'en': 'By continuing, you accept our',
    },
    'usn6e7v7': {
      'fr': ' Conditions d\'utilisations ',
      'en': 'Conditions of use',
    },
    'l1u8bvx8': {
      'fr': 'et notre',
      'en': 'and our',
    },
    'aguwngxc': {
      'fr': ' Politique de confidentialité',
      'en': 'Privacy Policy',
    },
    '3c8sayiz': {
      'fr': 'Home',
      'en': 'Home',
    },
  },
  // stripeCompletion
  {
    'q6dxdn05': {
      'fr': 'Activer les paiements',
      'en': 'Enable payments',
    },
    'jleahain': {
      'fr': 'Valider mon compte',
      'en': 'Validate my account',
    },
    'c4cuy1n3': {
      'fr': 'Continuer',
      'en': 'Continue',
    },
    'z4d7ne6t': {
      'fr': 'Plus tard',
      'en': 'Later',
    },
    'q7eurjdi': {
      'fr': 'Home',
      'en': 'Home',
    },
  },
  // Profilsettings
  {
    'yffiue0l': {
      'fr': 'Prenom',
      'en': 'First name',
    },
    'b4xxawpr': {
      'fr': 'Nom',
      'en': 'Name',
    },
    't9s7v9j3': {
      'fr': 'Adresse email',
      'en': 'E-mail address',
    },
    '3iocowg0': {
      'fr': 'Numéro de téléphone',
      'en': 'Phone number',
    },
    '8p1wbw3u': {
      'fr': 'Je veux vendre des plats',
      'en': 'I want to sell dishes',
    },
    's6hkoh13': {
      'fr': 'Adresse',
      'en': 'Address',
    },
    '07u4f6k4': {
      'fr': 'Option 1',
      'en': 'Option 1',
    },
    'uv0952xj': {
      'fr': 'Ville',
      'en': 'City',
    },
    '9hskxwux': {
      'fr': 'Option 1',
      'en': 'Option 1',
    },
    'pc3rbb95': {
      'fr': 'Code postal',
      'en': 'Postal code',
    },
    'nnns7x7h': {
      'fr': 'Option 1',
      'en': 'Option 1',
    },
    '3sr3ie58': {
      'fr': 'Confirmer',
      'en': 'Confirm',
    },
    '3u69o9fj': {
      'fr': 'Modifer vos informations',
      'en': 'Edit your information',
    },
    '5s4socl1': {
      'fr': 'Home',
      'en': 'Home',
    },
  },
  // chatGroupPage
  {
    'byeyiohk': {
      'fr': 'Commencez à écrire',
      'en': 'Start writing',
    },
    '4dfau1um': {
      'fr': 'Home',
      'en': 'Home',
    },
  },
  // addGroup
  {
    'd899t0ut': {
      'fr': 'Nom du groupe',
      'en': 'Name of the group',
    },
    'nf49jyxd': {
      'fr': 'Description',
      'en': 'Description',
    },
    'hp35snq1': {
      'fr': 'Groupe privé',
      'en': 'Private group',
    },
    '6f20lqr4': {
      'fr': 'Groupe public',
      'en': 'Public group',
    },
    'pp1xncd7': {
      'fr': 'Confidentialité du groupe',
      'en': 'Group Privacy',
    },
    '0mwjc9v0': {
      'fr': 'Search for an item...',
      'en': 'Search for an item...',
    },
    'kxhtjoae': {
      'fr': 'Code de connexion',
      'en': 'Login code',
    },
    'r6pm49zd': {
      'fr': 'Code à partager pour rejoindre votre groupe sans invitation.',
      'en': 'Code to share to join your group without invitation.',
    },
    'kvnp3s80': {
      'fr': 'Rechercher l\'adresse',
      'en': 'Find address',
    },
    'mjj3n07a': {
      'fr': 'Créer le groupe',
      'en': 'Create the group',
    },
    'kdk6n9iz': {
      'fr': 'Créer un groupe',
      'en': 'Create a group',
    },
    'h13rizq7': {
      'fr': 'Home',
      'en': 'Home',
    },
  },
  // modifGroup
  {
    'nk42odpr': {
      'fr': 'Nom du groupe',
      'en': 'Name of the group',
    },
    'cf37qtbu': {
      'fr': 'Description',
      'en': 'Description',
    },
    'j9qxxyj5': {
      'fr': 'Groupe privé',
      'en': 'Private group',
    },
    'r46mm83b': {
      'fr': 'Groupe public',
      'en': 'Public group',
    },
    'i7x2xyd7': {
      'fr': 'Confidentialité du groupe',
      'en': 'Group Privacy',
    },
    '8hf9zhh3': {
      'fr': 'Search for an item...',
      'en': 'Search for an item...',
    },
    'w55wfc10': {
      'fr': 'Code de connexion',
      'en': 'Login code',
    },
    '770p4nqb': {
      'fr': 'Code à partager pour rejoindre votre groupe sans invitation.',
      'en': 'Code to share to join your group without invitation.',
    },
    'a2m0g7qr': {
      'fr': 'Nom du groupe',
      'en': 'Name of the group',
    },
    'sk72a9os': {
      'fr': 'Modifier l\'adresse',
      'en': 'Change address',
    },
    'oyfuw7k0': {
      'fr': 'Modifier le groupe',
      'en': 'Edit group',
    },
    '6kkob2sm': {
      'fr': 'Modifier le groupe',
      'en': 'Edit group',
    },
    'k3a06wf6': {
      'fr': 'Home',
      'en': 'Home',
    },
  },
  // ajouterUserGroupe
  {
    '91uub8jk': {
      'fr': 'Ajouter au groupe',
      'en': 'Add to group',
    },
    '2w4o5k53': {
      'fr': 'Rechercher un groupe ou un utilisateur',
      'en': 'Search for a group or user',
    },
    'xismk8x7': {
      'fr': 'Utilisateurs',
      'en': 'Users',
    },
    '8nrfbyf7': {
      'fr': 'Ajouter les membres',
      'en': 'Add members',
    },
    'p2mqs418': {
      'fr': 'Partager le lien d\'invitation',
      'en': 'Share invitation link',
    },
    '34k0z3l6': {
      'fr': 'Home',
      'en': 'Home',
    },
  },
  // connexionGroupe
  {
    '3jj2bf8i': {
      'fr': 'Rejoindre le groupe',
      'en': 'join the group',
    },
    '6jg9zv9f': {
      'fr': ' ',
      'en': '',
    },
    'p7k63ohl': {
      'fr': 'Code de connexion',
      'en': 'Login code',
    },
    'mzmls4ae': {
      'fr':
          'Ce groupe est privé. Le code de connexion doit vous être communiqué par un membre.',
      'en':
          'This group is private. The connection code must be communicated to you by a member.',
    },
    'guwpkbxi': {
      'fr': 'Rejoindre le groupe',
      'en': 'join the group',
    },
    '4e9sbo6j': {
      'fr': 'Home',
      'en': 'Home',
    },
  },
  // group_detail
  {
    '5tiu53zc': {
      'fr': 'Chat',
      'en': 'Cat',
    },
    'h0blhuuc': {
      'fr': 'Plats proposés dans le groupe',
      'en': 'Dishes offered in the group',
    },
    'h0xztt5b': {
      'fr': 'Membres du groupe',
      'en': 'Group members',
    },
    't5ns8ti9': {
      'fr': '',
      'en': '',
    },
    'h7sbbqn2': {
      'fr': 'Voir',
      'en': 'See',
    },
    'jjhy9y4m': {
      'fr': 'Rejoindre le groupe',
      'en': 'join the group',
    },
    'el9r89mv': {
      'fr': 'Inviter des utilisateurs',
      'en': 'Invite users',
    },
    'zopfx3z0': {
      'fr': 'Supprimer le groupe',
      'en': 'Delete group',
    },
    'ou92cxnd': {
      'fr': 'Quitter le groupe',
      'en': 'Leave the group',
    },
    'e6sl2vft': {
      'fr': 'Home',
      'en': 'Home',
    },
  },
  // ConnexionInscription
  {
    'omh40k5x': {
      'fr': 'Prêt(e) à vous lancer en deux minutes ?',
      'en': 'Ready to get started in two minutes?',
    },
    'rpp63vhh': {
      'fr': 'C’est entièrement gratuit en plus !',
      'en': 'It’s completely free too!',
    },
    '2x5jr423': {
      'fr': 'Connexion',
      'en': 'Connection',
    },
    '49v7bclt': {
      'fr': 'Créer un nouveau compte',
      'en': 'Create a new account',
    },
    'szcv10m6': {
      'fr': 'Onboarding',
      'en': 'On boarding',
    },
  },
  // Livraison
  {
    'ot1fovda': {
      'fr': 'Annuler votre commande',
      'en': 'Cancel your order',
    },
    'vn5whvp4': {
      'fr': 'Refuser la commande',
      'en': 'Refuse the order',
    },
    'invpw1w0': {
      'fr': 'Annuler votre commande',
      'en': 'Cancel your order',
    },
    'huj005x0': {
      'fr': 'Refuser la commande',
      'en': 'Refuse the order',
    },
    'ybvtrqsw': {
      'fr': 'La commande est prête',
      'en': 'The order is ready',
    },
    'd5tuc0nd': {
      'fr': 'En attente de la confirmation du paiement',
      'en': 'Waiting for payment confirmation',
    },
    'om83k9q1': {
      'fr': 'Recommencer le paiement',
      'en': 'Start payment again',
    },
    'u0kke6rm': {
      'fr': 'Annuler votre commande',
      'en': 'Cancel your order',
    },
    'h5lgeann': {
      'fr': 'Le paiement a échoué',
      'en': 'Payment failed',
    },
    'cugasmx0': {
      'fr': 'Recommencer le paiement',
      'en': 'Start payment again',
    },
    'tl6noen9': {
      'fr': 'Home',
      'en': 'Home',
    },
  },
  // Notifications
  {
    '4lvqnp5p': {
      'fr': 'Mes commandes en cours',
      'en': 'My current orders',
    },
    '3g8kiyzo': {
      'fr': 'Mes notifications',
      'en': 'My notifications',
    },
    'fmguiide': {
      'fr': 'Nouvelle commande',
      'en': 'New order',
    },
    'ls1ryq1b': {
      'fr': 'Nouveau message',
      'en': 'New message',
    },
    'qn9avyri': {
      'fr': 'Home',
      'en': 'Home',
    },
  },
  // modifierPlat
  {
    '1328yg1c': {
      'fr': 'Modifier votre plat',
      'en': 'Modify your dish',
    },
    '0q93m1i0': {
      'fr': 'Nom du plat',
      'en': 'Name of the dish',
    },
    '9dn4ggin': {
      'fr': 'Ingrédient',
      'en': 'Ingredient',
    },
    '4n8ucqkt': {
      'fr': 'Plat cuisiné',
      'en': 'A cooked dish',
    },
    '73rfca8u': {
      'fr': 'Quel type de plat ?',
      'en': 'What type of dish?',
    },
    'i49dg5rk': {
      'fr': 'Search for an item...',
      'en': 'Search for an item...',
    },
    'g62qgslp': {
      'fr': 'Prix (€)',
      'en': 'Price (€)',
    },
    'hue3x9n2': {
      'fr': 'Ingrédients',
      'en': 'Ingredients',
    },
    'ifsgrglr': {
      'fr': 'Allergènes',
      'en': 'Allergens',
    },
    'razrjtxm': {
      'fr': 'Quantité',
      'en': 'Quantity',
    },
    'ulo0we7f': {
      'fr': 'À qui souhaitez vous vendre ce plat ?',
      'en': 'Who do you want to sell this dish to?',
    },
    'r4lwgc6g': {
      'fr': 'Mes voisins',
      'en': 'My neighbors',
    },
    'ojolhdfi': {
      'fr': 'Toutes les personnes dans mes groupes',
      'en': 'Everyone in my groups',
    },
    'efczwbzv': {
      'fr': 'À tout le monde (voisins et groupes)',
      'en': 'To everyone (neighbors and groups)',
    },
    'hst7mh48': {
      'fr': 'À un ou des groupes en particulier',
      'en': 'To one or more groups in particular',
    },
    'udlxqd4a': {
      'fr': 'Garder en brouillon',
      'en': 'Keep in draft',
    },
    '6n5vvbpn': {
      'fr': 'À qui voulez vous proposer ce plat ?',
      'en': 'Who do you want to offer this dish to?',
    },
    '1ton2a5m': {
      'fr': 'Search for an item...',
      'en': 'Search for an item...',
    },
    'mr1pt7el': {
      'fr': 'À quels groupes voulez-vous vendre ?',
      'en': 'Which groups do you want to sell to?',
    },
    'l2ghqjw7': {
      'fr': 'Modifier le plat',
      'en': 'Edit the dish',
    },
    't3t4tf9v': {
      'fr': 'Field is required',
      'en': 'Field is required',
    },
    'y24rln8b': {
      'fr': 'Please choose an option from the dropdown',
      'en': 'Please choose an option from the dropdown',
    },
    '8uv5rhfn': {
      'fr': 'Field is required',
      'en': 'Field is required',
    },
    'v1syszqj': {
      'fr': 'Please choose an option from the dropdown',
      'en': 'Please choose an option from the dropdown',
    },
    'm4lv5a1d': {
      'fr': 'Field is required',
      'en': 'Field is required',
    },
    '6udvs5y4': {
      'fr': 'Please choose an option from the dropdown',
      'en': 'Please choose an option from the dropdown',
    },
    '3l57ki20': {
      'fr': 'Field is required',
      'en': 'Field is required',
    },
    'wfdl63fb': {
      'fr': 'Please choose an option from the dropdown',
      'en': 'Please choose an option from the dropdown',
    },
    'op77tukw': {
      'fr': 'Home',
      'en': 'Home',
    },
  },
  // Aucunelement
  {
    'j8bd9qfo': {
      'fr': 'Aucun élément',
      'en': 'No items',
    },
  },
  // Switchpage
  {
    'riepcl4u': {
      'fr': 'Vos collègues',
      'en': 'Your colleagues',
    },
    '9kioiwla': {
      'fr': 'Vos voisins',
      'en': 'Your neighbors',
    },
  },
  // UserCard
  {
    '5nxlzsjx': {
      'fr': 'Cuisine certifiée',
      'en': 'Certified cuisine',
    },
  },
  // ProfilSettingsCard
  {
    '08fs74bo': {
      'fr': 'Modifier le profil',
      'en': 'modify the profile',
    },
  },
  // UserCardBack
  {
    '3tdrrfrx': {
      'fr': 'Cuisine certifiée',
      'en': 'Certified cuisine',
    },
  },
  // Demarrerconv
  {
    'sdxxeie8': {
      'fr': 'Démarrez la conversation !',
      'en': 'Start the conversation!',
    },
  },
  // NoGroup
  {
    'hdbjorbz': {
      'fr': 'Vous n\'avez pas encore de discussion en groupe !',
      'en': 'You don\'t have a group chat yet!',
    },
  },
  // NoChats
  {
    'rvnt1yez': {
      'fr': 'Vous n\'avez pas encore de conversation active !',
      'en': 'You don\'t have an active conversation yet!',
    },
    '396omjd0': {
      'fr': 'Démarrer une conversation',
      'en': 'Start a conversation',
    },
  },
  // NoPlats
  {
    '2wschvmh': {
      'fr':
          'Il n\'y a pas de plats autour de vous, invitez vos amis pour en voir plus !',
      'en': 'There are no dishes around you, invite your friends to see more!',
    },
    'cyove2st': {
      'fr': 'Ajouter mes amis',
      'en': 'Add my friends',
    },
  },
  // NoIngredient
  {
    'gauc0lpl': {
      'fr':
          'Il n\'y a pas d\'ingrédients près de vous, invitez vos amis pour en voir plus !',
      'en':
          'There are no ingredients near you, invite your friends to see more!',
    },
  },
  // selectMainAction
  {
    'wd8fya8a': {
      'fr': 'Générer des recettes par IA avec une photo de votre frigo ',
      'en': 'Generate recipes by AI with a photo of your fridge',
    },
    'kuw2tj78': {
      'fr': 'Bientôt disponible',
      'en': 'Available soon',
    },
    'xslqs1zi': {
      'fr': 'Vendre un plat ou des ingrédients sur NourriShare',
      'en': 'Sell ​​a dish or ingredients on NourriShare',
    },
    'wzb3dwio': {
      'fr': 'Mettre en vente',
      'en': 'Sell',
    },
  },
  // Miscellaneous
  {
    'ydk7ch0c': {
      'fr': '',
      'en': '',
    },
    'ncj1tlcw': {
      'fr': '',
      'en': '',
    },
    'q3jolvzd': {
      'fr': 'Pour vous montrer les plats proche de chez vous !',
      'en': 'To show you the dishes near you!',
    },
    'ks99elld': {
      'fr': 'Pour vous aider à communiquer plus rapidement.',
      'en': 'To help you communicate faster.',
    },
    'sm77nszq': {
      'fr': 'Pour trouver les meilleurs plats proche de chez vous ! ',
      'en': 'To find the best dishes near you!',
    },
    '1lcgorf4': {
      'fr': 'Pour vous prévenir des commandes et livraisons !',
      'en': 'To notify you of orders and deliveries!',
    },
    'ab3efg68': {
      'fr': 'Pour les photos de votre délicieux plat !',
      'en': 'For photos of your delicious dish!',
    },
    'ij77flza': {
      'fr': 'Pour les photos de votre délicieux plat !',
      'en': 'For photos of your delicious dish!',
    },
    '9tnzw6o3': {
      'fr': 'Pour que vous puissiez inviter vos amis et vos collèges !',
      'en': 'So you can invite your friends and colleagues!',
    },
    'p9fh3khq': {
      'fr': 'Le mot de passe ou l\'adresse mail est invalide.',
      'en': 'The password or email address is invalid.',
    },
    'p693jd9j': {
      'fr':
          'Un lien pour réinitialiser votre mot de passe vous a été envoyé par mail.',
      'en': 'A link to reset your password has been sent to you by email.',
    },
    'q7jkqszn': {
      'fr': 'Votre email est requis pour réinitialiser votre mot de passe.',
      'en': 'Your email is required to reset your password.',
    },
    'dkltgfjq': {
      'fr':
          'Un numéro de téléphone est attendu avec ce format (ex : +33601020304).',
      'en':
          'A telephone number is expected with this format (eg: +33601020304).',
    },
    '8qkcwdtu': {
      'fr':
          'Votre mot de passe et le mot de passe de confirmation ne sont pas les mêmes.',
      'en': 'Your password and the confirmation password are not the same.',
    },
    'f6cv9zcq': {
      'fr': '',
      'en': '',
    },
    'hu44hkw0': {
      'fr': '',
      'en': '',
    },
    'raux2dmz': {
      'fr': '',
      'en': '',
    },
    'yy09xxsg': {
      'fr': '',
      'en': '',
    },
    'klf1g420': {
      'fr': 'Cet email est déjà utilisé sur l\'application.',
      'en': 'This email is already used on the application.',
    },
    'jctqrkwv': {
      'fr': 'Vous utilisez un format de fichier non valide.',
      'en': 'You are using an invalid file format.',
    },
    'a05hq3iz': {
      'fr': 'Téléchargement du fichier',
      'en': 'File download',
    },
    'yjwesk6d': {
      'fr': 'Fichier téléchargé ! ',
      'en': 'File downloaded!',
    },
    'pbrnslxi': {
      'fr': 'Le téléchargement a échoué.',
      'en': 'Download failed.',
    },
    'lt4qebvu': {
      'fr': '',
      'en': '',
    },
    'sikikhwv': {
      'fr': 'Choisissez la source',
      'en': 'Choose the source',
    },
    'mi5vfvmo': {
      'fr': 'Gallerie',
      'en': 'Gallery',
    },
    'z9q41njy': {
      'fr': 'Gallerie (Photo)',
      'en': 'Gallery (Photo)',
    },
    '4o3fp1rc': {
      'fr': 'Gallerie (Video)',
      'en': 'Gallery (Video)',
    },
    'ea7cgt6o': {
      'fr': 'Camera',
      'en': 'Camera',
    },
    'zqfpj79t': {
      'fr': '',
      'en': '',
    },
    '7lf8ovbb': {
      'fr': '',
      'en': '',
    },
    '690lba2s': {
      'fr': '',
      'en': '',
    },
    'ycgz2f1n': {
      'fr': '',
      'en': '',
    },
  },
].reduce((a, b) => a..addAll(b));
