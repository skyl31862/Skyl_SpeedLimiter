README - Skyl_Limiteur

============================== FRANÇAIS ==============================

Skyl_Limiteur est un limiteur de vitesse simple et léger pour FiveM.
Il permet au conducteur de bloquer son véhicule à la vitesse actuelle
avec une touche, tout en restant facile à installer et à configurer.

Fonctionnalités

- Activation et désactivation du limiteur via une touche.
- Limiteur appliqué uniquement aux classes de véhicules autorisées.
- Blocage de l’activation si le véhicule roule trop vite.
- HUD optionnel à l’écran lorsque le limiteur est actif.
- Support des notifications avec ESX / QBCORE / QBOX / CUSTOM ou ox_lib.
- Fonctionnement client léger et propre.

Prérequis

- Serveur FiveM.
- ESX / QBCORE / QBOX / CUSTOM.
- ox_lib facultatif si vous souhaitez utiliser ses notifications.

Installation

1. Placez la ressource dans le dossier resources de votre serveur.
2. Vérifiez que le nom du dossier est bien skyl_speedlimiter.
3. Ajoutez la ressource à votre configuration serveur :

   ensure skyl_speedlimiter

4. Configurez la ressource selon les besoins de votre serveur.
5. Redémarrez le serveur ou relancez la ressource.

Configuration

La ressource se configure depuis le fichier config.lua.

Vous pouvez notamment y définir :

- la touche par défaut du limiteur
- la vitesse maximale autorisée avant activation
- l’arrondi de la vitesse
- le système de notification utilisé
- les textes de notification
- les classes de véhicules autorisées
- l’affichage du HUD et sa position

Fonctionnement

- Le joueur doit être conducteur du véhicule.
- Le limiteur peut uniquement être activé sur les classes autorisées.
- Lors de l’activation, le script bloque le véhicule sur une vitesse arrondie.
- Si le joueur sort du véhicule ou change de véhicule, le limiteur se désactive automatiquement.
- Le limiteur peut être coupé manuellement à tout moment.

Touche

Une touche par défaut est définie dans la configuration, mais les joueurs
peuvent aussi modifier leur raccourci directement dans les paramètres
de touches de FiveM.

Notifications

Systèmes de notifications sont pris en charge :

- ESX / QBCORE / QBOX / CUSTOM.
- ox_lib

Le système utilisé peut être choisi dans la configuration.

Notes

- Le limiteur est pensé pour un usage classique en véhicule
  et dépend des classes autorisées dans la configuration.

Exemple d’utilisation

- Roulez à la vitesse souhaitée.
- Appuyez sur la touche configurée.
- Le véhicule reste bloqué à cette vitesse.
- Appuyez de nouveau sur la touche pour désactiver le limiteur.

Auteur

Skyl31862


============================== ENGLISH ===============================

Skyl_Limiteur is a simple and lightweight speed limiter for FiveM.
It allows the driver to lock the vehicle at the current speed
with a key, while remaining easy to install and configure.

Features

- Enable and disable the limiter with a key.
- Limiter only applies to allowed vehicle classes.
- Prevent activation if the vehicle is going too fast.
- Optional on-screen HUD when the limiter is active.
- Notification support with ESX / QBCORE / QBOX / CUSTOM or ox_lib.
- Lightweight and clean client-side behavior.

Requirements

- FiveM server.
- ESX / QBCORE / QBOX / CUSTOM.
- ox_lib is optional if you want to use its notifications.

Installation

1. Place the resource in your server's resources folder.
2. Make sure the folder name is skyl_speedlimiter.
3. Add the resource to your server configuration:

   ensure skyl_speedlimiter

4. Configure the resource to fit your server's needs.
5. Restart the server or restart the resource.

Configuration

The resource is configured through the config.lua file.

You can define things such as:

- the default limiter key
- the maximum allowed speed before activation
- speed rounding
- the notification system used
- notification texts
- allowed vehicle classes
- HUD display and position

How It Works

- The player must be the driver of the vehicle.
- The limiter can only be activated on allowed vehicle classes.
- When activated, the script locks the vehicle to a rounded speed value.
- If the player exits the vehicle or switches vehicles,
  the limiter is automatically disabled.
- The limiter can be turned off manually at any time.

Keybind

A default key is defined in the configuration, but players can also
change their shortcut directly in the FiveM keybind settings.

Notifications

Notification systems are supported:

- ESX / QBCORE / QBOX / CUSTOM.
- ox_lib

The system used can be selected in the configuration.

Notes

- The limiter is intended for standard vehicle use
  and depends on the allowed classes set in the configuration.

Example Usage

- Drive at the desired speed.
- Press the configured key.
- The vehicle stays locked at that speed.
- Press the key again to disable the limiter.

Author

Skyl31862
