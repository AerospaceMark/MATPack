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

