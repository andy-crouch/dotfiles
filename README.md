![image](README_IMAGES/dotfiles.png)

# My .dotfiles & *nix configuration. 

This repository contains the various .dotfiles and configuration settings that I use to configure my *nix based environments.  I currently use [Manjaro i3 Community Edition ](https://manjaro.org/download/community/i3/) across a range of laptops and Virtual Machines.

**Important Note - ** This repository previously had a custom script to handle the linking and management of files. I have now switched to using [GNU Stow](https://www.gnu.org/software/stow/) to manage the linking of the files in this repository. If you have previously used this repository as a basis for managing your *.dotfiles* then please update your code based on the new method.

This is ***my*** repository and designed to be useful to me.  I have spent a number of years trying to tame the files within but I do not focus a lot of time on the code.  If you would find it useful then I have no issue with you forking it and using it to manage your .dotfiles and configuration settings.  

If you see something you want to change or fix then I am open to and encourage Pull Requests.

## How it works.

All .dotfiles for an application are stored in a top level directory within the *.dotfiles* repository, for example _bash/_ or _zsh/_. Any custom file configuration such as splitting aliases or functions out of your main bash configuration are stored in a sub-directory of the application directory. This directory is named _application_config_ for example _bash/bash_config_.

![image](README_IMAGES/Config_Example.png)

To restore the .dofiles for a particular application you can use stow and tell it which application to restore.

```shell
$ stow bash
```

## Themes, settings and configurations.

Each theme, setting and configuration I manage via this repository is documented on the [wiki](https://github.com/andy-crouch/dotfiles/wiki).  Click a link below to find out more:

* [i3-gaps theme, settings and configuration ]()
* [Git]()
* [Shell theme]()
* [Bash settings and configuration]()
* [zsh settings and configuration]()
* [Nitrogen]()

#### Shell Theme

I used the [Nord](https://github.com/arcticicestudio/nord) theme across my shell(s) and editors.  You can find the various sources from:

* **.dir_colors** - [Github](https://github.com/arcticicestudio/nord-dircolors).  My configuration uses the Nord source as is.
* **.Xresrouces** - [Github](https://github.com/arcticicestudio/nord-xresources).  My configuration stores the colour codes in *.dotfiles/urxvt/.nord-urxvt-colors.*

#### i3

My **i3** configuration in *.dotfiles/.i3.symlink*.  At present this is the standard i3 configuration from Manjaro i3.

#### Nitrogen

[Nitrogen](https://github.com/l3ib/nitrogen) is a background setter for i3.  

I have added the *bg-saved.cfg* and *nitrogen.cfg* files to *.dotfiles/* so that my selected background is available when i3's configuration attempts to restore it (see [i3](#i3)). 

The image files are stored in the *backgrounds/* directory.  The configuration will use the *wallpaper.jpg* file for both the wallpaper and the lockscreen background.  If you want seperate images to be used then add the background for the lockscreen as *lockscreen.jpg*.

## Getting Started


In order to get started you should clone this repository with the following command:

```
git clone https://github.com/andy-crouch/dotfiles.git ~/.dotfiles
```

This will download **my** dotfiles and settings.  If you decide to fork this repository then my settings will show you how I have structured the files and settings and give you a boilerplate repository to use for your own.  

### Prerequisites

To clone and run the repository and the ***dotfiles*** script you only really need **git** and a shell such as Bash or Zsh.

To run the ***test.sh*** script in the root of the .dotfiles/ directory you will need to have [shellcheck](https://www.shellcheck.net/) installed.

### Installing

If you want to just install my environment then ensure you have the applications installed in the [Prerequisites](prerequisites) section above and run:

```
cd ~/.dotfiles
./dotfiles -i
```

## Running the tests

The ***test.sh*** script in the root of the .dofiles/ directory will use [shellchecker](https://github.com/koalaman/shellcheck) to catch issues with any scripts.  To run the script, run:

```cd ~/.dotfiles
cd ~/.dotfiles
./test.sh
```

Any errors or linting issues will be streamed to the console.

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to me.

## Versioning

The current version of the **./dotfiles** project is 0.9.9

#### Project versioning mechanism 

This repository is using a simple **MAJOR.MINOR.CHANGE** versioning system where:

* **MAJOR** - Will only change when there is a significant and breaking change to ***dotfiles*** or any scaffolding or management script.
* **MINOR** - Will only change when there is a significant and breaking change to a mechanism for managing and configuring an application sub system.
* **CHANGE** - Will only change for changes and additions to files and settings.

## Authors

* **Andy Crouch** - [Email](mailto:email@amcrou.ch) | [Twitter](https://twitter.com/amcrouch) 

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgements

* Zac Holman [dotfiles](https://github.com/holman/dotfiles) - Original inspiration for the ***dofiles*** script.
* Jess Frazelle [dotfiles](https://github.com/jessfraz/dotfiles) - Excellent reference scripts.  Unashamedly stole her script testing script.  I highly recommend you follow her on [twitter](https://twitter.com/jessfraz?lang=en). 

