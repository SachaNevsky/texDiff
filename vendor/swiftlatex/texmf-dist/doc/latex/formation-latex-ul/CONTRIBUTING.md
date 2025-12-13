<!-- Emacs: -*- coding: utf-8; eval: (auto-fill-mode -1); eval: (visual-line-mode t) -*- -->

# Collaborer au projet *Rédaction avec LaTeX*

Le projet [Rédaction avec LaTeX](https://vigou3.gitlab.io/formation-latex-ul) est hébergé dans un [dépôt public GitLab](https://gitlab.com/vigou3/formation-latex-ul).

La branche `master` du dépôt est réservée en écriture au gestionnaire du projet.

Pour collaborer au projet, vous devez publier vos modifications dans une nouvelle branche et effectuer une demande de tirage (*pull request*) vers la branche `master`. La procédure à suivre à partir d'une interface en invite de commande (Git Bash sous Windows ou Terminal sous macOS) est la suivante.

1. Si  vous travaillez sur le code source pour la première fois, déplacez-vous avec la commande `cd` dans le répertoire dans lequel vous voulez enregistrer le code source du projet (le répertoire `formation-latex-ul` sera créé automatiquement), clonez le dépôt et déplacez-vous ensuite dans le dossier du code source.

```
git clone https://gitlab.com/vigou3/formation-latex-ul.git
cd formation-latex-ul
```

**OU**

1. Si vous avez déjà cloné le dépôt dans le passé et que vous voulez reprendre le travail sur le code source, déplacez-vous avec la commande `cd` dans le répertoire du code source, puis mettez à jour votre copie locale du dépôt depuis la branche `master`.

```
git checkout master
git pull
```

2. Créez une branche (locale) pour vos modifications.

```
git checkout -b <nom_de_branche>
```
	
3. Effectuez maintenant vos modifications. Il y a un fichier par chapitre et son nom, avec une extension `.tex`, a un lien évident avec le titre du chapitre. N'effectuez des modifications que dans un seul fichier à la fois! Lorsque les modifications sont terminées, publiez le fichier modifié dans votre dépôt local avec un commentaire utile, mais bref, sur la nature des modifications.
    
```
git status
git add <fichier>
git commit -m "<commentaire>"
```
	
4. Créez un compte dans GitLab si vous n'en avez pas déjà un. Publiez ensuite la branche avec les modifications dans le dépôt GitLab.

```
git push -u origin <nom_de_branche>
```
	
5. Finalement, [connectez-vous](https://gitlab.com/users/sign_in) à l'interface graphique de GitLab et effectuez une demande de fusion (*Merge Request*) vers la branche `master` en sélectionnant l'option correspondante dans la barre latérale.
