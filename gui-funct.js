var is = require("electron-is");

// Mac and Linux have Bash shell scripts (so the following would work)
//        var child = process.spawn('child', ['-l']);
//        var child = process.spawn('./test.sh');       
// Win10 with WSL (Windows Subsystem for Linux)  https://docs.microsoft.com/en-us/windows/wsl/install-win10
//   
// Win10 with Git-Bash (windows Subsystem for Linux) https://git-scm.com/   https://git-for-windows.github.io/
//

const { ipcRenderer } = require('electron')
var $ = require('jquery');
var dragFile = document.getElementById("drag-file");
dragFile.addEventListener('drop', function(e) {
    e.preventDefault();
    e.stopPropagation();

    for (let f of e.dataTransfer.files) {
        console.log('The file(s) you dragged: ', f);
        ipcRenderer.send('ondragstart', f.path)
    }

});

dragFile.addEventListener('dragover', function(e) {
    e.preventDefault();
    e.stopPropagation();
});

ipcRenderer.on('fileData', (event, data) => {
    const process = require('child_process'); // The power of Node.JS

    var cmd = './zip_to_lbx.sh';
    var child = process.spawn(cmd, [data]);

    child.on('error', function(err) {
        console.log('stderr: <' + err + '>');
    });

    child.stdout.on('data', function(data) {
        console.log(data.toString('utf8') );
    });

    child.stderr.on('data', function(data) {
        console.log('stderr: <' + data + '>');
    });

    child.on('close', function(code) {
        if (code == 0) {
            console.log('child process complete.');
        } else {
            console.log('child process exited with code ' + code);
        }
    });

});