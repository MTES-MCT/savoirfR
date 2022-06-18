# Comment contribuer

## Ajouter des exercices à un module

### Créer une branche.
En partant de la branche master, créer une branche spécifique

### Rajouter les données manquantes dans `inst/extdata`

Chaque jeu de données doit être limité en taille à quelques centaines de lignes et quelques colonnes.

Compléter le fichier `extdata/list_data_modules.csv` en rajoutant une ligne pour chaque dataset du module.

### Rajouter les exercices dans `inst/vignettes/nom_du_module/`

Chaque fichier doit avoir `exoN.Rmd` ou `exoN.rmd` ou encore `exoN.rmarkdown`
Knitter la vignette pour vérifier qu'elle compile
Sourcer le script `dev/extract_r_files.R` pour extraire les enonces et les exercices.
Vérifier que les fichiers R ont bien été extraits dans les dossiers :

* `inst/rstudio/templates/project/ressources/nom_du_module/enonces`

* `inst/rstudio/templates/project/ressources/nom_du_module/corrections`

### Modifier la vignette

Pour appeler l'exercice dans la vignette ou dans parcours-r il faut utiliser un chunk :

Pour afficher l'énoncé seuleument :
```{r mod5_exo1, child=charge_exo("m5", "exo1.rmd"), echo=FALSE}
```
Pour afficher l'énoncé et la correction :
```{r mod5_exo1_solution, child=charge_exo("m5", "exo1.rmd"), echo=TRUE}
```

### testez que tout fonctionne

- faites un check du package

- appuyer sur install & restart

- tentez de créer un projet avec le template

### Intégrer vos changements à la branche principale

- commiter les changements
- effectuer une merge request de votre branche vers la branche principale

