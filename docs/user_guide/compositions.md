# Compositions

Zeus Enhanced adds the ability to create custom compositions through Zeus.

Custom compositions exist under a special category in the empty compositions tree, named "Custom" and marked with an icon on the right-hand side.

### Managing

Custom compositions can be created, edited, and deleted by pressing the respective buttons in the panel below the tree.

A new composition is created by selecting all of the objects that should be part of the composition and pressing the create button. A menu to input the composition's category and name will be shown. 
Compositions are saved to the user's Arma 3 profile. File is *.vars.Arma3Profile (* username)

*Location of arma profile file*
Windows -> %localappdata%\Arma 3
Linux -> /home/X/.local/share/Arma 3/

An existing composition's category and name can be edited by selecting it in the tree and pressing the edit button.

Lastly, compositions can be deleted by selecting the composition to delete in the tree and pressing the delete button. This requires an additional step to confirm the deletion.

## Managing in game

Get debug / console
```hpp
copyToClipboard str (profileNamespace getVariable "zen_compositions_data"
```
ZEN composition data can be restored with this command as well
```hpp
profileNamespace setVariable ["zen_compositions_data", (array here)]; saveProfileNamespace
```

### Spawning

Custom compositions can be spawned by selecting the composition to spawn in the tree and proceeding with the normal Zeus placement procedure.
