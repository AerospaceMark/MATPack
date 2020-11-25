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
