# What do all the functions do?

## addPackage()

```MATLAB
addPackage(pathToPackage,packageName)
```
This function adds new MATLAB packages to your possible package directory. This function can be used in two ways:

1. Clone an online Git repository to your Documents/MATLAB folder.
- In this case, the `pathToPackage` input is a cloning URL, which you get from the website for any online Git repository (like this one!).
- The `packageName` input is optional, and is for renaming the package to your own custom name. (ie. if you wanted to add a package originally called `general-signal-processing` and wanted to call it just `SignalAnalysis`, you would type `SignalAnalysis` in the `packageName` input. 
2. Copy a package from any location on your computer to the Documents/MATLAB folder. **Note, however, that support for packages outside the Documents/MATLAB folder is limited. It is recommended that you always keep your packages stored in the Documents/MATLab folder.**
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

## createNewBranch()
```MATLAB
createNewbranch(packageName,branchName,includeRemote)
```
This function enables you to create new branches. The third argument is boolean (true/false) and tells MATLAB whether to create a remote branch too. The default is true.

For the current release, the ability to merge and delete branches has not been included. These actions are more serious and if done improperly can lead to some large headaches. Therefore, for now, it is recommended that these actions be done either online, inside an interactive GUI, or directly on the command line. The command line can be directly accessed in MATLAB by prefacing commands with an exclamation point (!), like so:

```MATLAB
!git status
!git commit -m "cool commit"
!git branch -d testbranch
```
