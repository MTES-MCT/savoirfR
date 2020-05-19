# Comment contribuer

## Ajouter des exercices à un module

### Créer une branche.
En partant de la branche master, créer une branche spécifique

### Rajouter les données manquantes dans `inst/extdata`

Chaque jeu de données doit être limité en taille à quelques centaines de lignes et quelques colonnes.

Compléter le fichier `extdata/list_data_modules.csv` en rajoutant une ligne pour chaque dataset du module.

### Rajouter les énoncées dans `inst/rstudio/templates/project/ressources/nom_du_module/enonces`

Chaque fichier doit avoir comme nom `exoN.R` ou `exoN.Rmd`.

### Rajouter les corrections dans `inst/rstudio/templates/project/ressources/nom_du_module/corrections`

Chaque fichier doit avoir comme nom `exoN.R` ou `exoN.Rmd`, comporter l'énoncé et la correction documentée.

### testez que tout fonctionne

- faites un check du package

- appuyer sur install & restart

- tentez de créer un projet avec le template

### Intégrer vos changements à la branche principale

- commiter les changements
- effectuer une merge request de votre branche vers la branche principale
