# MATPack

In many programming languages, reusable code is bundled together into packages. Examples include [Python](https://www.python.org/), [Julia](https://julialang.org/), and [R](https://www.r-project.org/). These packages perform all kinda of tasks ranging from optimized linear algebra routines, to machine learning algorithms, to improved formatting for plots. MATLAB does not have a built-in way to have packages in the same way as these other languages, and this is where MATPack enters the scene.

MATPack is designed to give you the benefits of bundling your useful code into callable packages. For example, if you had written a lot of generalized signal processing code, you could put it into a package and call it as

```python
usePackage GeneralSignalProcessing
```

where `GeneralSignalProcessing` is the name of the package. All of the code within that package suddenly becomes available to you in whatever directory you are using.

MATPack also enables sharing MATLAB packages through online Git repositories. To add a package from an online Git repository, simply type

```python
addPackage 'insert cloning url'
```

where the cloning url is replaced with the specific url for the package you would like to add. Once you've added a package, it now becomes available to be "used" in your other code.

In order to use MATPack, you need to install Git command line tools. This means being able to execute Git commands in your local terminal (for MacOS and Linux users) or in your local command prompt ([for Windows users](https://stackoverflow.com/questions/11000869/command-line-git-on-windows)). To learn more about Git, see the manual [So, You Want To Use Git?](https://github.com/Mark-C-Anderson/So-You-Want-To-Use-Git).

# Everything You Need to Know Right Now

## Installing and Using MATPack

1. Clone this repository to your Documents/MATLAB folder. This is where all packages will be stored.
2. Type the following code into the command window:

```python
MATPack_path = genpath(strcat(userpath,filesep,"MATPack"));
addpath(MATPack_path)
```
If you want to avoid doing this every time you open MATLAB, then go to the same Documents/MATLAB folder and create a MATLAB file called `startup.m`. Paste the above code into that file. The `startup.m` file will automatically run every time you open MATLAB and automatically include MATPack.

## Typical Workflow

To add a package to your computer, simply run the `addPackage` command, followed by the cloning url of the desired repository

```python
addPackage https://github.com/Mark-C-Anderson/OptimizedRocket.git
```

The above code clones the `OptimizedRocket` package to your Documents/MATLAB path. If you now want to use functions or scripts from the `OptimizedRocket` package in your current code, then you simply need to run the `usePackage` command, followed by the name of the package.

```python
usePackage OptimizedRocket
```

And there you go! All of the code in the `OptimizedRocket` package is now available for you to use in whatever directory you are using.

Imagine being able to build up your own packages, and use well-written packages by your colleagues in your code. Instead of manually adding each of the folders to your path, you simply can have a few lines at the top of your code, like so:

```python
usePackage FancyPlots
usePackage FourierAnalysis
usePackage LinearAlgebraSuite
usePackage TurbulentFlow
usePackage NumericalDerivatives
```

If you want to create your own packages, simply store the code for each package as a Git repository within the Documents/MATLAB path on your computer. To learn more about Git, see the manual [So, You Want To Use Git?](https://github.com/Mark-C-Anderson/So-You-Want-To-Use-Git).

And tha's all you need to know to start using MATPack to improve your work! This will definitely be a huge benefit to you as you continue to organize your work and become more productive. Using packages will help you maintain cleaner code with a higher degree of reproducibility.

# Working with Manifest Files

## Creating a Manifest File
A `Manifest` file contains a list of packages and commit IDs. This enables **full reproducibility** in your code, even if different packages have changed. For example, the 'ArrayAnalysis' package might be structured like so:

- ArrayAnalysis/
  - src/
  - test/
  - docs/
  - README.md
  
Let's say that you wanted ArrayAnalysis to be dependent on the 'GeneralSignalProcessing' package. You would navigate to the 'ArrayAnalysis' package folder and type:

```MATLAB
addToManifest('GeneralSignalProcessing')
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

```MATLAB
addToManifest('SourceModels','4819100e4d348b00e0b8bca16ff0d164b7abb416')
```

The numbers are the particular commit ID for the commit that you want to use. You can use either the long or the short commit.

It's important to note the differences between the different options for that second argument. You can type five different things:

```MATLAB
addToManifest('SourceModels')
addToManifest('SourceModels','current')
addToManifest('SourceModels','master')
addToManifest('SourceModels',branchName)
addToManifest('SourceModels',commitID)
```

Options 1 and 2 are equivalent. They take the current commitID and freeze the package. This means that if 'SourceModels' was updated that 'ArrayAnalysis' will not use the updates. This enables a high degree of reproducibility because if you commit frequently then you have a record of which commits were being used. You can then check out the 'ArrayAnalysis' package at a different commit and then `instantiate` (described below) the packages as they all were at the time you made that commit.

Option 3 will tell MATLAB to always grab the master branch, even if the package you're using has been updated. This makes development easy while you're working on multiple packages that use each other, though is not good for reproducibility down the road because specific commits are never given.

Option 4 will tell MATLAB to always grab the top commit of the branch that you specify. This is equivalent to option 3, you're just using a branch other than master.

Option 5 lets you put in either the long or the short commit ID for any point in the history of the package. This is good if a code update caught you by surprise and you want to force MATLAB to use the old version. This works for any commit on any branch.

## Using a Manifest File
If the code you're working on has a `Manfiest.csv` file, then all you have to do to get all of the packages to obey it is type:

```MATLAB
instantiatePackages()
```

and MATLAB will automatically use the `forgetAllPackages()` function to remove all packages from the current path and then automatically check out all of the proper versions of the packages specified in the `Manifest.csv` file. Note that checking out different commits of the packages for different coding projects works best if each project has its own `Manifest.csv` file, so that you always use the correct version of each package for each project.

When you know that you have made several changes to the packages upon which your current code depends, use the `updateManifest` function:

```MATLAB
updateManifest()
```

You must be in the same folder as the manifest file. This function will read the manifest file, checkout each package at the top of the master branch, and then replace the previous commit ID with the commit ID that corresponds to the current top of the master branch. This is different than using the `master` option when adding packages to the manifest file because the actual commit ID is used and therefore the manifest file will not track changes in the master branch of the dependencies, and you will need to update the manifest file as pertinent changes are made to the dependencies.
