const vscode = require('vscode');

const child_process = require("child_process");
const path = require("path");

const PromiseSeries = require('promise-series');

// TODO word forward should skip underscores

function wordCase(cb) {
    return function() {
        let startPos = vscode.window.activeTextEditor.selection.active;

        vscode.commands.executeCommand("cursorWordRight").then(() => {
            let endPos = vscode.window.activeTextEditor.selection.active;
            let range = new vscode.Range(startPos, endPos);
            let word = vscode.window.activeTextEditor.document.getText(range);
            vscode.window.activeTextEditor.edit(function(builder) {
                builder.replace(range, cb(word));
            });
        });
    }
}

function macro(...commands) {
    return function() {
        let series = new PromiseSeries();
        for (let command of commands) {
            series.add(() => { return vscode.commands.executeCommand(command) })
        }
        return series.run()
    }
}

var commands = {
    "vroy.uppercaseWord": wordCase((word) => word.toUpperCase()),

    "vroy.lowercaseWord": wordCase((word) => word.toLowerCase()),

    "vroy.capitalizeWord": wordCase((word) => {
        return word.charAt(0).toUpperCase() + word.slice(1).toLowerCase();
    }),

    "vroy.copy": macro(
        "multiclip.copy",
        "emacs.exitMarkMode"
    ),

    "vroy.paste": macro(
        "multiclip.paste",
        "emacs.exitMarkMode"
    ),

    "vroy.cut": macro(
        "multiclip.cut"
    ),

    "vroy.cutToEndOfLine": macro(
        "cursorEndSelect",
        "multiclip.cut"
    ),

    "vroy.killLine": macro(
        "expandLineSelection",
        "multiclip.cut"
    ),

    "vroy.marked": function() {
        var filePath = vscode.window.activeTextEditor.document.fileName;
        var fileName = path.basename(filePath);

        // filePath and fileName are the same in a new untitled document.
        if (filePath === fileName) {
            vscode.window.showErrorMessage("Cannot open unsaved document in Marked.");
            return;
        }

        child_process.exec(`open -a Marked ${filePath}`);
    }
}

function activate(context) {
    for (var name in commands) {
        var fn = commands[name];
        let disposable = vscode.commands.registerCommand(name, fn);
        context.subscriptions.push(disposable);
    }
}

function deactivate() {
}

exports.activate = activate;
exports.deactivate = deactivate;
