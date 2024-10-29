    Restreindre les permissions du fichier /var/log/bs_client/bs_client.log afin qu'il ne soit accessible qu'à l'utilisateur serveur avec des permissions d’écriture minimales donc on va faire un changement des droits pour limiter les accès

----------------------
```
def restricted_user():
    try:
        # Créer un utilisateur système avec un shell restreint
        subprocess.run(["sudo", "useradd", "-r", "-s", "/usr/sbin/nologin", "server_user"], check=True)
        
        # Changer le propriétaire des fichiers de l’application
        app_path = "/path/to/app"  # Remplacez par le chemin de votre application
        subprocess.run(["sudo", "chown", "-R", "server_user:server_user", app_path], check=True)
        
        print("Utilisateur limité 'server_user' créé et application sécurisée.")
    except subprocess.CalledProcessError as e:
        print(f"Erreur lors de la création de l'utilisateur : {e}")

Explication du code :
```
    La fonction  restricted_user crée un utilisateur système server_user avec un shell restreint, puis attribue la propriété du dossier de l’application à cet utilisateur. Remplacez "/path/to/app" par le chemin réel de votre application.

```
def restrict_log_file_permissions():
    log_file = "/var/log/bs_client/bs_client.log"  # Chemin du fichier journal

    try:
        # Changer le propriétaire du fichier vers l'utilisateur serveur
        subprocess.run(["sudo", "chown", "server_user:server_user", log_file], check=True)
        
        # Restreindre les permissions du fichier : lecture et écriture uniquement pour l'utilisateur
        os.chmod(log_file, 0o600)  # 600 -> -rw-------

        print(f"Permissions du fichier {log_file} modifiées avec succès.")
    except Exception as e:
        print(f"Erreur lors de la modification des permissions du fichier : {e}")

if __name__ == "__main__":
    restrict_log_file_permissions()
```
Les permissions 600 signifient que seul le propriétaire du fichier (dans ce cas, server_user) peut lire et écrire dans le fichier. Les autres utilisateurs n’ont aucun accès.