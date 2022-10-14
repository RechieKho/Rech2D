# Rechie's Godot 2D Codebase
This repository consists of many helper script and act as a foundation for many of my 2D projects.

# NOTE: These scripts are for Godot 3.X and *NOT* Godot 4

## Structure
Each top-level folders are individual modules, and its name is self-explanatory. The modules are depended on each other so **it might not work if you try to only include one of the module**.  For each modules, there will have 4 kinds of folders, shown as below.

| Type | description |
| ----- | ----- |
| `@Abstracts` | Contains classes that should not be used directly, they are to be `extend`ed instead. |
| `@Autoloads` | Autoload scripts. *MUST* be added as autoload before using the modules |
| `@Nodes` | Node scripts. Use it as normal script. |
| `@Scenes` | Scenes. |
| `@SimpleClasses` | Simple data classes. |

