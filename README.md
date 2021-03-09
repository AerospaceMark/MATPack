# MATPack

What if you could organize your MATLAB code into useful bundles and then easily incorporate those bundles into your other projects? MATPack enables you to create code `packages` that can be used within your other code by simply typing

```python
usePackage 'package name'
```

This enables you to organize your code in a way that is useful not only to you now, but also to your colleagues and future self.

The idea of code packages is nothing new. In many programming languages, reusable code is bundled together into packages. Examples include [Python](https://www.python.org/), [Julia](https://julialang.org/), and [R](https://www.r-project.org/), where packages perform all kinds of tasks ranging from optimized linear algebra routines, to machine learning algorithms, to improved formatting for plots. MATLAB does not have a built-in way to have packages in the same sense as these other languages, and this is where MATPack comes into play.

MATPack is designed to give you the benefits of bundling your useful code into packages that can be called in other files and functions. For example, if you've written a lot of generalized signal processing code, you could put it into a package and call it as

```python
usePackage GeneralSignalProcessing
```

where `GeneralSignalProcessing` is the name of the package. After executing this command, all of the code within that package becomes available to you.

MATPack also enables sharing MATLAB packages through online Git repositories. To add a package from an online Git repository, simply type

```python
addPackage 'insert cloning url'
```

where the cloning url is replaced with the specific cloning url for the package you would like to add. Once you've added a package, it now becomes available to be "used" in your code.

In order to use MATPack, you need to install [Git command line tools](https://git-scm.com/). This means being able to execute Git commands in your local terminal (for MacOS and Linux users) or in your local command prompt ([for Windows users](https://stackoverflow.com/questions/11000869/command-line-git-on-windows)). To learn more about Git, consider looking at the manual [So, You Want To Use Git?](https://github.com/Mark-C-Anderson/So-You-Want-To-Use-Git).

# Everything You Need to Know Right Away

## Installing and Using MATPack

1. Clone this repository to your Documents/MATLAB folder. If that folder does not exist, go ahead and create it. This is where all packages will be stored.
2. Type the following code into the command window:

```python
MATPack_path = genpath(strcat(userpath,filesep,"MATPack"));
addpath(MATPack_path)
```

If you want to avoid doing this every time you open MATLAB, then go to the same Documents/MATLAB folder and create a MATLAB file called `startup.m`. Paste the above code into that file. The `startup.m` file will automatically run every time you open MATLAB and automatically include MATPack for you.

## Typical Workflow

To create a package, create it as a Git repository within your Documenst/MATLAB folder. Or, to add a package from online to your computer, simply run the `addPackage` command, followed by the cloning url of the desired repository. For example:

```python
addPackage https://github.com/Mark-C-Anderson/OptimizedRocket.git
```

The above code clones the `OptimizedRocket` package to your Documents/MATLAB path. If you now want to use functions or scripts from the `OptimizedRocket` package in your current code, then you simply need to run the `usePackage` command once at the top of your code, followed by the name of the package.

```python
usePackage OptimizedRocket
```

And there you go! All of the code in the `OptimizedRocket` package is now available for you to use.

Imagine being able to build up your own packages, and use well-written packages by your colleagues in your code. Instead of manually adding each of the folders to your path, you simply can have a few lines at the top of your code, like so:

```python
usePackage FancyPlots
usePackage NumericalDerivatives
usePackage LinearAlgebraSuite
usePackage FourierAnalysis
usePackage TurbulentFlow
```

And that's all you need to know to start using MATPack! Think of all the places you could go if code only had to be written once, and could then be called as a package when needed later. Think of the time you will save the the improved productivity your team can have when collaborating on packages to move your work forward.

# Enabling Full Reproducibility

The above mini-tutorial contains everything you need to know to immediately up your coding game in MATLAB. However, MATPack not only helps you organize and use your code better, it also enables **full reproducibility**.

Imagine a world where you can exactly replicate results from six months ago. MATPack enables this by using a [Julia-inspired](https://docs.julialang.org/en/v1/stdlib/Pkg/) system of keeping track of which package versions are being used. All you have to do is tell MATPack which package versions you want to use and MATPack will automatically remember this and be able to use the proper versions. This is kept track of as a `Manifest.csv` file within each package.

## What is a Manifest File?
A `Manifest.csv` file contains a list of packages that your current code (or package) depends on. A package upon which your code depends on is called a `dependency` (ie. if the 'TurbulentFlow' package needs to use the 'NumericalDerivatives' package in order to function properly, then 'NumericalDerivatives' is a dependency of 'TurbulentFlow'). In addition to a list of package names, the manifest file also contains a Git commit ID for each package. The reason that this is useful is because you can run the `instantiatePackages` command (discussed below) to automatically check out each commit of each package that your code depends on. This means that you could check out your code exactly as it was six months or even two years ago!

## Creating a Manifest File
A `Manifest` file contains a list of packages and commit IDs. This enables full reproducibility in your code, even if different packages have changed over time. For example, the 'ArrayAnalysis' package might be structured like so:

- ArrayAnalysis/
  - src/
  - test/
  - docs/
  - README.md
  
Let's say that you wanted 'ArrayAnalysis' to be dependent on the 'GeneralSignalProcessing' package. You would navigate to the 'ArrayAnalysis' package folder and type:

```python
addToManifest GeneralSignalProcessing
```

This will create a file called `Manifest.csv` in the main folder of 'ArrayAnalysis':

- ArrayAnalysis/
  - src/
  - test/
  - docs/
  - Manifest.csv
  - README.md
  
If you open the manifest file you will see that it has a column for the package name and another column for the commit ID. Unless specified, the commit ID will default to whatever the current commit of that package is. 

Let's say that you now want to add the 'SourceModels' package to the manifest file, but that you want to specify a particular commit ID. You could type:

```python
addToManifest('SourceModels','4819100e4d348b00e0b8bca16ff0d164b7abb416')
```

The numbers are the particular commit ID for the commit that you want to use. You can use either the long or the short commit.

It's important to note the differences between the different options for that second argument. You can type five different things:

```python
addToManifest SourceModels
addToManifest('SourceModels','current')
addToManifest('SourceModels','main')
addToManifest('SourceModels',branchName)
addToManifest('SourceModels',commitID)
```

Options 1 and 2 are equivalent. They take the current commitID and freeze the package. This means that if 'SourceModels' has been updated since you added it to your manifest file that 'ArrayAnalysis' will not use the updates. This enables a high degree of reproducibility because if you commit frequently then you have a record of which commits were being used. You can then check out the 'ArrayAnalysis' package at a different commit and then `instantiate` (described below) the packages as they all were at the time you made that commit.

Option 3 will tell MATLAB to always grab the main/master branch (whichever is specified), even if the package you're using has been updated. This makes development easy while you're working on multiple packages that use each other, though is not good for reproducibility down the road because specific commits are never given.

Option 4 will tell MATLAB to always grab the top commit of the branch that you specify. This is equivalent to option 3, you're just using a branch other than main.

Option 5 lets you put in either the long or the short commit ID for any point in the history of the package. This is good if a code update caught you by surprise and you want to force MATLAB to use the old version. This works for any commit on any branch.

## Using a Manifest File
If the code you're working on has a `Manfiest.csv` file, then all you have to do to use all of the packages to obey it is type:

```python
instantiatePackages
```

and MATLAB will automatically use the `forgetAllPackages` function to remove all packages from the current path and then automatically check out all of the proper versions of the packages specified in the `Manifest.csv` file. Note that checking out different commits of the packages for different coding projects works best if each project has its own `Manifest.csv` file, so that you always use the correct version of each package for each project.

When you know that you have made several changes to the packages upon which your current code depends, use the `updateManifest` function:

```python
updateManifest
```

You must be in the same folder as the manifest file. This function will find out the commit ID for the top of the main branch for each package in the manifest file and update the manifest file with the corresponding commtit IDs. This is different than using the `main` option when adding packages to the manifest file because the actual commit ID is used and therefore the manifest file will not track changes in the master branch of the dependencies, and you will need to update the manifest file as pertinent changes are made to the dependencies.

If you only want to update one package in the manifest file, simply run the `addToManifest` command again, denoting the dependency that you would like to update, and MATPack will replace the commitID within the manifest file.

# Answers to Questions You May Have

* "Will I become the person at work whose code is now useless for everyone else?"
  * MATPack packages are exactly like all other MATLAB code. The only difference is that a package will have a `Manifest.csv` file in it, which does not affect your code whatsoever unless the user calls the `instantiatePackages` command. This means that your colleagues can use your code regardless of whether they use MATPack. However, they will need to manually add the paths to each package on their computer, which is really a bummer for them and a chance for you to point them in a more effecient direction.

* "Can attackers use MATPack to pass system commands directly to my terminal?"
  * Each time a system command is run in MATPack, the command is checked for special characters such as "!,?,#,&,..." and several others. If any of these symbols are found within a command, MATPack will inform the user that the command cannot be run. We do not guarantee perfect protection, but we do try to discourage those with bad intentions from harming your computer.

# Questions/Comments

Go ahead and submit a GitHub issue to notify the developer. If you'd like, go ahead and fork this repository, fix the issue, and submit a pull request.

Developer: Mark C. Anderson
Institution: Brigham Young University
