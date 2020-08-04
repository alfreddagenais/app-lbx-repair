# Repair LBX Files App

An HTML5 stand alone app using GitHub Electron (Chrome engine + Node.js) to help repair LBX Files

## What is an LBX file?

The LBX file type is primarily associated with Foxpro by Microsoft Corporation. LBX file is simply a renamed ZIP contain xml and other datas

## SETUP

1. Install GitHub's Electron
2. initialize node modules
3. run application

### Install GitHub's Electron
```Shell
$ sudo npm i -D electron@latest
```

### initialize node modules
```Shell
$ npm install
```

### run application
```Shell
$ npm start
--- or ---
$ electron .
```

## Create application

1. Install GitHub's Electron Packager
3. Build application

### Install GitHub's Electron Packager
```Shell
$ sudo npm install electron-packager -g
```

### Build application
```Shell
$ electron-packager . --icon=logo_lbx_repair.icns
```
Please note : Some time the bash script not working with this method