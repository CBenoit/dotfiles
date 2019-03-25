# Antisèche VIM pour BÉPO (en BÉPO-QWERTY)

Dans cette antisèche, l'esperluette « & » représente la touche leader.
Les commentaires avec « (*) » à la fin sont des raccourcis créés ou modifiés dans [ma configuration VIM](https://github.com/CBenoit/vim-config).

+ [Mode normal](#mode-normal)
    + [Déplacement](#déplacement)
    + [Insertion](#insertion)
    + [Changement de mode](#changement-de-mode)
    + [Presse papier](#presse-papier)
    + [Défaire, refaire](#défaire-refaire)
    + [Manipulation du texte](#manipulation-du-texte)
    + [Recherche](#recherche)
    + [Raccourcis](#raccourcis)
    + [Les replis](#les-replis)
+ [Mode commande](#mode-commande)
+ [Mode visuel](#mode-visuel)
    + [Insertion](#insertion)
    + [Manipulation du texte](#manipulation-du-texte-1)
+ [Plugin UltiSnips](#plugin-ultisnips)
+ [Plugin Multiple cursors](#plugin-multiple-cursors)
+ [Plugin ctrlP](#plugin-ctrlp)
+ [Plugin LustyExplorer](#plugin-lustyexplorer)
+ [Plugin Ack](#plugin-ack)
+ [Plugin Tabular](#plugin-tabular)
+ [Plugin NeoComplete](#plugin-neocomplete)
+ [Plugin vim2hs](#plugin-vim2hs)

## Mode normal

### Déplacement

```
c — déplacement sur la gauche
t — déplacement vers le bas
s — déplacement vers le haut
r — déplacement vers la droite
é — début du mot suivant
É — début du MOT suivant
p — fin du mot suivant
P — fin du MOT suivant
k — début du mot précédent
K — début du MOT précédent
} — paragraphe suivant
{ — paragraphe précédent
,t — aller à l'onglet gauche
,s — aller à l'onglet droit
C — bas de l'écran
R — haut de l'écran
; — bas du fichier
,, — haut du fichier
```

### Insertion

```
d — insertion avant
D — insertion fin de ligne
a — insertion après
A — insertion début de ligne
l — insère une nouvelle ligne en dessous de la ligne courante et passe en mode insertion
L — insère une nouvelle ligne au dessus de la ligne courante et passe en mode insertion
u — supprime le caractère sous le curseur et passe en mode insertion
U — supprime la ligne et passe en mode insertion
```

### Changement de mode

```
N — mode commande
. — mode visuel
: — mode visuel ligne
ESCAPE — retour au mode normal
ii — alias de ESCAPE (*)
```

### Presse papier

```
^ — copier
ç — copier
! — copier ligne
j — coller après
J — coller avant
```

### Défaire, refaire

```
v — défaire
V — défaire ligne
CTRL-r — refaire
```

### Manipulation du texte

```
o — remplacer le caractère sous le curseur
y — supprimer/couper sous le curseur
Y — supprimer/couper avant le curseur
T — supprimer le caractère de la ligne de fin à la fin de la ligne courante
```

### Recherche

```
f — chercher (vers le bas)
F — chercher (vers le haut)
' — aller à la prochaine occurence
? — aller à l'occurence précédente
```

### Raccourcis

```
&w — sauvegarder le fichier courant (*)
&q — fermer le fichier courant (*)
&cd — changer le répertoire de travail de tous les onglets à celui du fichier courant (*)
&lcd — changer le répertoire de travail de l'onglet courant à celui du fichier courant (*)
&s — alias de PageUp (*)
&t — alias de PageDown (*)
```

### Les replis

```
ào – ouvrir un repli (à un niveau).
àc — fermer un repli (à un niveau).
àa — ouvrir un repli fermé, fermer un repli ouvert (à un niveau).
àO — àC — àA — pareil, mais à tous les niveaux.
àr — ouvre tout un niveau de replis.
àR — ouvre tous les replis.
àm — ferme tout un niveau de replis.
àM — ferme tous les replis.
```

## Mode commande

```
42 — aller à la ligne 42

w — sauvegarder
w!! — sauvegarder avec sudo (*)
q — quitter
new — nouveau fichier
```

## Mode visuel

### Insertion

```
u — supprime les caractères sélectionnés et passe en mode insertion
U — supprime la ligne et passe en mode insertion
```

### Manipulation du texte

```
o — remplacer les caractères sélectionnés
v — mettre en minuscule la sélection
V — mettre en majuscule la sélection
y — supprimer/couper la sélection
```

## Plugin UltiSnips

```
CTRL-j — valider l'ouverture d'un snippet
    (dans un snippet) aller à la zone suivante
CTRL-k — (dans un snippet) aller à la zone précédente
CTRL-TAB — afficher les snippets correspondants
```

## Plugin Multiple cursors

```
CTRL-n — (en mode normal) surligne le mot sous le curseur et place
                          un curseur virtuel à la fin
        (après avoir sélectionné le premier mot) trouve la prochaine
                          occurrence du mot et place un autre
                          curseur virtuel à la fin
        (en mode visuel) place un curseur virtuel à chaque ligne et
                         retourne en mode normal
CTRL-p — (après avoir sélectionné des mots) supprime le dernier
                           curseur virtuel et retourne au précédent
CTRL-x — (après avoir sélectionné des mots) supprime le dernier
            curseur virtuel et en place un à la prochaine occurrence
ESCAPE — retour au VIM normal
```


## Plugin ctrlP

```
&c — lancer une recherche avec ctrlP (*)
```

## Plugin LustyExplorer

```
&f — ouvrir l'exploreur de fichiers (*)
&r — ouvrir l'exploreur de fichiers en partant du fichier courant (*)
&b — ouvrir l'exploreur de buffers (*)
&g — lancer une recherche dans les buffers (*)
```

## Plugin Ack

```
&j — prépare la commande Ack pour lancer une recherche (*)
&ja — prépare une recherche du mot sous le curseur (*)
&jA — prépare une recherche du MOT sous le curseur (*)
```

## Plugin Tabular

```
&a= — aligne en fonction du caractère « = » (*)
&a: — aligne en fonction du caractère « : » (*)
```

## Plugin NeoComplete

```
TAB — (dans le menu d'autocompletion) sélectionner la proposition suivante. (*)
CTRL-g — défait la completion. (*)
CTRL-y — ferme la popup de completion. (*)
```

## Plugin vim2hs

Commande
```
HPaste — partager du code sur http://lpaste.net
```

