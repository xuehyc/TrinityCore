<p align="center"> <img src="https://raw.githubusercontent.com/MobiusDevelopment/MobiusCore/master/logo.png"/></p>

<p align="center">
  <a href="#introduction">Introduction</a> •
  <a href="#requirements">Requirements</a> •
  <a href="#install">Install</a> •
  <a href="#copyright">Copyright</a> •
  <a href="#authors--contributors">Authors &amp; Contributors</a> •
  <a href="#links">Links</a>
</p>

---

## Introduction

MobiusCore is a *MMORPG* Framework based mostly in C++.<br>
It is derived from *MaNGOS*, the *Massive Network Game Object Server*.


### Conclusions after researching for a decent project
+ Repacks cannot be trusted, because most of them are distributed without sources.
+ Badly written code, with no coding standards is hard to track and can result to unwanted game behavior.
+ Communicating with TrinityCore, or other projects, gets offensive for no reason at most times.
+ Everyone mentions how special his project is, but still using actual MaNGOS sources.


### Mentality behind the creation of MobiusCore
+ Nostagia for Legion, the expansion that brought the players back to the game, before lore was decimated.
+ Create a community interested in working and sharing openly missing content using the same coding standards.
+ Prefer missing content that can be added relatively easy over time, than no control over the sources.
+ Find the most clean fork of TrinityCore before 7.3.5 branch was removed and move forward from there.


## Requirements

+ MySQL 5.7.0
+ Boost 1.68 x64
+ CMake 3.21.3 x64
+ OpenSSL 1.0.2j x64
+ MS Visual Studio 2019


## Install

What you should do to open project on Windows.
+ Install MySQL server
+ Restore the database backups
+ Install MS Visual Studio 2019
+ Install OpenSSL at C:\OpenSSL-Win64
+ Install or compile Boost at C:\boost_1_68_0
+ Set enviroment variable BOOST_ROOT to C:/boost_1_68_0/ (requires restart)
+ Install CMake
+ Generate project files with CMake
+ Go to your build folder and open MobiusCore.sln

<i>*If you are not familiar with any of the above a google search is highly recommended.</i>


## Copyright

License: GPL 2.0

Read file [COPYING](COPYING).


## Authors &amp; Contributors

Read file [AUTHORS](AUTHORS).


## Links

* [MySQL](https://dev.mysql.com/downloads/mysql/5.7.html)
* [Boost](https://boostorg.jfrog.io/artifactory/main/release/1.68.0/)
* [CMake](https://cmake.org/download/)
* [OpenSSL](https://www.mediafire.com/file/9otndn68ymb9egc/Win64OpenSSL-1_0_2j.exe/file)
