# MATPack
Welcome to the MATLAB Package Manager!

MATPack is designed to make designing packages in MATLAB very user-friendly. The original motivation for MATPack came while working in a research group at Brigham Young University. We decided that we wanted to bundle our useful code into packages that future students and professors could easily access and use, very similar to Python and Julia packages and libraries.

In order to use MATPack to its full potential, you need to install Git command line tools. This means being able to execute Git commands in your local terminal (for MacOS and Linux users) or in your local command prompt (for Windows users).

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
```

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
usePackage(packageName)
```
This function looks for a MATLAB package, and then adds it to your current MATLAB path. Note that when you add a package using the `addpackage()` function, the package becomes available to be added to your current path, but it is not actually added until you use the `usePackage()` command. This can also be used in two ways:

1. Add a package directly from the Documents/MATLAB path. In this case the `packageName` input is simply the name of the package.
```MATLAB
usePackage('ArrayAnalysis')
```
2. Add a package from somewhere else on your computer. In this case the `packageName` input is the absolute path to the package on your computer.
```MATLAB
usePackage('C:/Users/Joe/Desktop/Code/ArrayAnalysis')
```

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

## removePackage
```MATLAB
removePackage(packageName)
```
This function deletes a package from your Documents/MATLAB path.

## openPackage
```MATLAB
openPackage(packageName)
```
This function changes your current MATLAB path to be inside the named package.

## updatePackage
```MATLAB
updatePackage(packageName)
```
This function pulls the latest updates from the package's online Git repository.

## commitPackage
```MATLAB
commitPackage(packageName,commitMessage)
```
This function stages and commits all of your changes to the named package.

```
updatePackage('ArrayAnalysis','Added header comments')
```

## pushPackage
```MATLAB
pushPackage(packageName)
```
This function pushes all of your commits to the online Git repository for the named package.
