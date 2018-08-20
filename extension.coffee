root = exports ? this

vscode = require "vscode"
fmt = require "coffee-fmt"


activate = (context) ->

    disposable = vscode.commands.registerCommand 'extension.formatIt', () ->
        editor = vscode.window.activeTextEditor
        doc = editor?.document

        config = vscode.workspace.getConfiguration "myCoffeeScriptFormatter"

        coffee = fmt.format doc?.getText(), {"tab": config.indentation}

        editor.edit (e) ->
            start = new vscode.Position 0, 0
            end = new vscode.Position(doc?.lineCount - 1, doc.lineAt(doc.lineCount - 1).text.length)
            range = new vscode.Range(start, end)
            e.replace(range, coffee)
        .then (r) ->
            postion = editor.selection.end; 
            editor.selection = new vscode.Selection(postion, postion)

    context.subscriptions.push(disposable)

exports.activate = activate

deactivate = () ->

exports.deactivate = deactivate