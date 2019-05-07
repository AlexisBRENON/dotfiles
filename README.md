My Linux Configuration
======================

> Set of files to build a descent working station

Changing computer or reinstalling your system can be a frightening process because of the time passed to install and configure all your favorite applications.
This, is a set of files to quickly setup my computer to suits my habits.

## My Applications

ArchLinux wiki provides a [great list of applications](https://wiki.archlinux.org/index.php/List_of_applications) for most of the usages.
Here is my selection:

 * [NetworkManager](https://wiki.archlinux.org/index.php/NetworkManager) with `nm-applet`: Internet/Network connection/Network managers
 * [Chromium](https://www.chromium.org/Home): Internet/Web browser
 * [Eyes of Gnome](https://wiki.gnome.org/Apps/EyeOfGnome): Multimedia/Image/Image viewer
 * [GIMP](https://www.gimp.org/): Multimedia/Image/Raster graphics editor
 * [Inkscape](https://inkscape.org/): Multimedia/Image/Vector graphics editor
 * [Draw.io](https://about.draw.io/) online for diagrams: Multimedia/Image/Vector graphics editor
 * [ImageMagick](https://imagemagick.org/index.php) (see `./screenshot.sh`): Multimedia/Image/Screenshot
  * [Xfce4 Screenshooter](https://goodies.xfce.org/projects/applications/xfce4-screenshooter) to test
 * [PulseAudio Volume Control](https://freedesktop.org/software/pulseaudio/pavucontrol/): Multimedia/Audio/Volume control
 * [VLC Media Player](https://www.videolan.org/vlc/): Multimedia/Audio,Video/Player
 * [Terminator](https://gnometerminator.blogspot.com/): Utilities/Terminal
 * [Thunar](https://docs.xfce.org/xfce/thunar/start): Utilities/File manager
 * [IntelliJ](https://www.jetbrains.com/idea/): Utilities/Development/IDE
  * Vim for quick and small devs
 * [XNeural Switcher](https://xneur.ru/) to test: Utilities/Text input/Keyboard switcher
 * [HTop](http://hisham.hm/htop/): Utilities/System/Task manager
 * ???: Utilities/System/Font viewer
 * [Vim](https://www.vim.org/): Documents/Text editor
 * [LibreOffice](https://www.libreoffice.org/): Document/Office
 * [Evince](https://wiki.gnome.org/Apps/Evince): Document/Reader/PDF
 * [Light Locker](https://github.com/the-cavalry/light-locker): Security/Screen locker
 * [KeePassXC](https://keepassxc.org/): Security/Password management
 * [SpeedCrunch](http://speedcrunch.org/): Science/Mathematics/Calculator
 * [LightDM](https://www.freedesktop.org/wiki/Software/LightDM/): Other/Display manager
 * [Xfce](https://xfce.org/): Other/Desktop environment
  * [Sway](https://swaywm.org/) to test (wayland tilling)
 * [Xfce4 Panel](https://docs.xfce.org/xfce/xfce4-panel/start): Other/Taskbar
 * [Rofi](https://github.com/davatorium/rofi/): Other/Applications launcher
 * [Zsh](https://sourceforge.net/p/zsh/code/ci/master/tree/): Other/Shell

### Old ones

Here are some that I used/tested in the past:

 * [Awesome](https://awesomewm.org/): Other/Windows manager
 * [Kupfer](https://kupferlauncher.github.io/): Other/Applications launcher

---

These list are not exhaustive and need to be completed.

## My Configurations

Once everything installed, you have to configure all these stuffs.
I tried to add a dedicated README in sub-folders to explain how to use them.
Here is some instructions for other files.

### Screenshot

Copy the `screenshot.sh` to a `PATH` referenced folder (like `${HOME}/.local/bin`).
Then you can bind the dedicated key to the script to make it possible to take screen shot.

### Readline

Readline is used by bash for command line editing.
The `readline.inputrc` file tries to mimic some ZSH behaviors.
Copy it to `${HOME}/.inputrc` and it should be ok.

### Vim

Without configuration, vim is unusable.
Copy the `vimrc` to "${HOME}/.vimrc"
Then install [Vundle](https://github.com/VundleVim/Vundle.vim) and run `:VundleInstall` in vim to install all plugins.

