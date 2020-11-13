# MATPack
Welcome to the MATLAB Package Manager!

MATPack is designed to make designing packages in MATLAB very user-friendly. The original motivation for MATPack came while working in a research group at Brigham Young University. We decided that we wanted to bundle our useful code into packages that future students and professors could easily access and use, very similar to Python and Julia packages and libraries.

In order to use MATPack, you need to install Git command line tools. This means being able to execute Git commands in your local terminal (for MacOS and Linux users) or in your local command prompt ([for Windows users](https://stackoverflow.com/questions/11000869/command-line-git-on-windows)).

# How to start using MATPack

1. Clone this repository to your Documents/MATLAB folder. This is where all packages will be stored.
2. Make sure both the terminal (or command prompt) and MATLAB are closed.
3. Open MATLAB
4. Type the following code into the command window:

```MATLAB
%--- adding MATPack
MATPack_path = genpath(strcat(userpath,filesep,"MATPack"));
addpath(MATPack_path)
clear('MATPack_path')
disp('Added: MATPack (MATLAB Package Manager)')
```
If you want to avoid doing this every time you open MATLAB, then go to the same Documents/MATLAB folder and create a MATLAB file called `startup.m`. Paste the above code into that file. The `startup.m` file will automatically run every time you open MATLAB and automatically include MATPack.

# Typical Workflow
## Getting and Using Packages
```MATLAB
addPackage('github.com/Joe/ArrayAnalysis') % add the package to your Documents/MATLAB folder

usePackage('ArrayAnalysis') % makes the contents of 'ArrayAnalysis' available in your current MATLAB path
```

## Working with Git
```MATLAB
updatePackage('ArrayAnalysis') % gets the latest updates in the online Git repository

%--- Let's pretend you made some changes to the 'ArrayAnalysis' package after updating it, and you want 
%    those to be posted to the online Git repository

packageStatus('ArrayAnalysis') % tells you what branch and commit you are currently on
                               % as well as what changes have been made but not yet committed

commitPackage('ArrayAnalysis','Improved function legibility') % stages and commits all of your latest 
                                                              % changes with the commit message 
                                                              % 'Improved function legibility'

pushPackage('ArrayAnalysis') % pushes your commits to the online Git repository 
                             % (assuming you have access to edit the online repository)                             
```

## Removing Packages
```MATLAB
forgetPackage('ArrayAnalysis') % forgets the package from your current active path

removePackage('ArrayAnalysis') % deletes a package completely from your computer
```

## Convenience
```MATLAB
openPackage('ArrayAnalysis') % Changes your current MATLAB path to be inside of the
                             % 'ArrayAnalysis' package.
                 
setAllToMaster() % Checks out all of the packages within the userpath at the master 
                 % branch
                 
forgetAllPackages() % Removes all of the packages in the userpath (Documents/MATLAB)
                    % from the current MATLAB path
```

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

It's important to note the differences between the different options for that second argument. You can type four different things:

```MATLAB
addToManifest('SourceModels')
addToManifest('SourceModels','current')
addToManifest('SourceModels','master')
addToManifest('SourceModels',commitID)
```

Options 1 and 2 are equivalent. They take the current commitID and freeze the package. This means that if 'SourceModels' was updated that 'ArrayAnalysis' will not use the updates. This enables a high degree of reproducibility because if you commit frequently then you have a record of which commits were being used. You can then check out the 'ArrayAnalysis' package at a different commit and then `instantiate` (described below) the packages as they all were at the time you made that commit.

Option 3 will tell MATLAB to always grab the master branch, even if the package you're using has been updated. This makes development easy while you're working on multiple packages that use each other, though is not good for reproducibility down the road because specific commits are never given.

Option 4 lets you put in either the long or the short commit ID for any point in the history of the package. This is good if a code update caught you by surprise and you want to force MATLAB to use the old version.

## Using a Manifest File
If the code you're working on has a `Manfiest.csv` file, then all you have to do to get all of the packages to obey it is type:

```MATLAB
instantiatePackages()
```

and MATLAB will automatically use the `forgetAllPackages()` function to remove all packages from the current path and then automatically check out all of the proper versions of the packages specified in the `Manifest.csv` file. Note that checking out different commits of the packages for different coding projects works best if each project has its own `Manifest.csv` file, so that you always use the correct version of each package for each project.

# What do all the functions do?

## addPackage()

```MATLAB
addPackage(pathToPackage,packageName)
```
This function adds new MATLAB packages to your possible package directory. This function can be used in two ways:

1. Clone an online Git repository to your Documents/MATLAB folder.
- In this case, the `pathToPackage` input is a cloning URL, which you get from the website for any online Git repository (like this one!).
- The `packageName` input is optional, and is for renaming the package to your own custom name. (ie. if you wanted to add a package originally called `general-signal-processing` and wanted to call it just `SignalAnalysis`, you would type `SignalAnalysis` in the `packageName` input. 
2. Copy a package from any location on your computer to the Documents/MATLAB folder.
- In this case, the `pathToPackage` is the absolute path on your computer to the package. The packageName option is not usable in this condition.

## usePackage()

```MATLAB
usePackage(packageName,commitID)
```
This function looks for a MATLAB package, and then adds it to your current MATLAB path. Note that when you add a package using the `addpackage()` function, the package becomes available to be added to your current path, but it is not actually added until you use the `usePackage()` command. This can also be used in two ways:

1. Add a package directly from the Documents/MATLAB path. In this case the `packageName` input is simply the name of the package.
```MATLAB
usePackage('ArrayAnalysis','300a12c')
```
2. Add a package from somewhere else on your computer. In this case the `packageName` input is the absolute path to the package on your computer.
```MATLAB
usePackage('C:/Users/Joe/Desktop/Code/ArrayAnalysis','master')
```

The second argument specifies the particular commit that you'd like to be using. It finds the package and then checks out the commit. Note that when you change which commit you are using then it is changed on your computer and other scripts may be affected. For this reason it is a good idea to reset your commit to be on 'master' when you're finished. If no second argument is given, then the default is 'master'.

## packageStatus()

```MATLAB
packageStatus(packageName)
```

This function looks for a MATLAB package, and then tells you it's status. This information will tell you what commit and branch you are on, as well as whether there are uncommitted changes.

## forgetPackage()
```MATLAB
forgetPackage(packageName)
```
This function removes a package from your current MATLAB path. Once a package is forgotten, its contents can no longer be used until the package is added again using the `usePackage()` command. The package is not deleted from your computer (see `removePackage()` for that). This can be used in two ways:

1. Forget a package directly from the Documents/MATLAB path. In this case the `packageName` input is simply the name of the package.
```MATLAB
forgetPackage('ArrayAnalysis')
```
2. Forget a package from somewhere else on your computer. In this case the `packageName` input is the absolute path to the package on your computer.
```MATLAB
forgetPackage('C:/Users/Joe/Desktop/Code/ArrayAnalysis')
```

## removePackage()
```MATLAB
removePackage(packageName)
```
This function deletes a package from your Documents/MATLAB path.

## openPackage()
```MATLAB
openPackage(packageName)
```
This function changes your current MATLAB path to be inside the named package.

## updatePackage()
```MATLAB
updatePackage(packageName)
```
This function pulls the latest updates from the package's online Git repository.

## commitPackage()
```MATLAB
commitPackage(packageName,commitMessage)
```
This function stages and commits all of your changes to the named package.

```
updatePackage('ArrayAnalysis','Added header comments')
```

## pushPackage()
```MATLAB
pushPackage(packageName)
```
This function pushes all of your commits to the online Git repository for the named package.
