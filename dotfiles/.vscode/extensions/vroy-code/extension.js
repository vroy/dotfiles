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

function editor() {
    return vscode.window.activeTextEditor;
}

function cursor() {
    return editor().selection.active;
}

function range() {
    let selection = editor().selection;
    return new vscode.Range(selection.start, selection.end);
}

function text() {
    return editor().document.getText(range());
}

function deleteCurrentSelection() {
    return editor().edit(builder => { builder.replace(range(), "") })
}

let ring = [ ];
let yanking = false;
let lastPasteStart = null;
let lastPasteEnd = null;
let lastPasteIndex = 0;

var commands = {
    "vroy.uppercaseWord": wordCase((word) => word.toUpperCase()),

    "vroy.lowercaseWord": wordCase((word) => word.toLowerCase()),

    "vroy.capitalizeWord": wordCase((word) => {
        return word.charAt(0).toUpperCase() + word.slice(1).toLowerCase();
    }),

    "vroy.killringdebug": function() {
        console.log(ring);
        console.log(`lastPasteStart: ${JSON.stringify(lastPasteStart)}`);
        console.log(`lastPasteEnd: ${JSON.stringify(lastPasteEnd)}`);
        console.log(`lastPasteIndex: ${lastPasteIndex}`);
    },

    "vroy.cancel": async function() {
        // todo implement mark mode myself
        await vscode.commands.executeCommand("emacs.exitMarkMode");
        await vscode.commands.executeCommand("hideSuggestWidget")
        yanking = false;
    },

    "vroy.copy": async function() {
        yanking = false;

        ring.unshift(text());

        // reset index so next paste is the new content.
        lastPasteIndex = 0;

        await vscode.commands.executeCommand("editor.action.clipboardCopyAction");
        await vscode.commands.executeCommand("emacs.exitMarkMode");
    },

    "vroy.cut": async function() {
        yanking = false;
        ring.unshift(text());

        // reset index so next paste is the new content.
        lastPasteIndex = 0;

        await vscode.commands.executeCommand("editor.action.clipboardCopyAction");
        await deleteCurrentSelection();
        await vscode.commands.executeCommand("emacs.exitMarkMode");
    },


    // todo support command palette selection similar to multiclip.list?
    // todo support pasting to multiple cursors?

    "vroy.paste": async function() {
        console.log("vroy.paste");
        yanking = true;

        lastPasteStart = cursor();
        await editor().edit(builder => builder.insert(lastPasteStart, ring[lastPasteIndex]))
        lastPasteEnd = cursor();
    },

    "vroy.pasteCycle": async function() {
        if (!yanking) {
            vscode.window.setStatusBarMessage("Previous command was not a yank", 3000);
            return;
        }

        // Increment here so that two pastes in a row paste the same index.
        lastPasteIndex++;

        if (lastPasteIndex >= ring.length) {
            lastPasteIndex = 0;
        }

        await editor().edit(builder => {
            builder.delete(new vscode.Range(lastPasteStart, lastPasteEnd));
            builder.insert(lastPasteStart, ring[lastPasteIndex]);
        });
        lastPasteEnd = cursor();
    },

    "vroy.indentLines": macro("editor.action.indentLines", "emacs.exitMarkMode"),
    "vroy.killWordRight": macro("cursorWordRightSelect", "vroy.cut"),
    "vroy.killWordLeft": macro("cursorWordLeftSelect", "vroy.cut"),
    "vroy.killToEndOfLine": macro("cursorEndSelect", "vroy.cut"),
    "vroy.killLine": macro("expandLineSelection", "vroy.cut"),
    "vroy.killToBeginningOfLine": async function() {
        let before = cursor();
        await vscode.commands.executeCommand("cursorLineStart");
        editor().selection = new vscode.Selection(before, cursor());
        await vscode.commands.executeCommand("vroy.cut");
    },

    "vroy.marked": function() {
        var filePath = editor().document.fileName;
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
